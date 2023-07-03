unit ShellFileSupport;

interface

uses
  ShlObj, ActiveX;

type
  TDriveNumber    = 0..25;
  TPathCharType   = (gctInvalid, gctLFNChar, gctSeparator, gctShortChar, gctWild);
  TPathCharTypes  = set of TPathCharType;
  TCleanupResult  = (pcsReplacedChar, pcsRemovedChar, pcsTruncated);
  TCleanupResults = set of TCleanupResult;
  PCleanupResults = ^TCleanupResults;

const
  InvalidDrive = TDriveNumber(-1);
  MAXPATHLEN = 1024;
  CSIDL_COMMON_APPDATA = $0023;
  CSIDL_COMMON_DOCUMENTS = $002E;


// ���������� ��� ������� �� ����
function PathGetCharType(const AChar: Char): TPathCharTypes;

// ���������� ����� ����� �� ���� (InvalidDrive ��� ������)
function PathGetDriveNumber(const APath: String): TDriveNumber;

// ��������� ���� � ��������� �������� ��������� �����
function PathBuildRoot(const ADrive: TDriveNumber): String;

// ������������ ����, ������ �� ���� ����������� �������� '.' � '..'
function PathCanonicalize(const APath: String): String;

// ��������� ��� ����, ��������, ��� �������������, ����������� ����
function PathAppend(const APath, AMore: String): String;

// ������ PathAppend, �� ���������� ���������� ���� (� ��������� '.' � '..')
function PathCombine(const APath, AMore: String): String;

// ���������� True, ���� ��������� ���� (����/�������) ����������
// ��������� �� ������, ���� �� �� ������ ������������ ������ FileExists/DirectoryExists �� Delphi
// ��.
// http://qc.embarcadero.com/wc/qcmain.aspx?d=3513
// http://qc.embarcadero.com/wc/qcmain.aspx?d=10731
// http://qc.embarcadero.com/wc/qcmain.aspx?d=52905
function PathFileExists(const APath: String): Boolean;

// ���������� True, ���� ���� - �������
// ��������� �� ������, ���� �� �� ������ ������������ ������ FileExists/DirectoryExists �� Delphi
// ��.
// http://qc.embarcadero.com/wc/qcmain.aspx?d=3513
// http://qc.embarcadero.com/wc/qcmain.aspx?d=10731
// http://qc.embarcadero.com/wc/qcmain.aspx?d=52905
function PathIsDirectory(const APath: String): Boolean;

// ���������� True, ���� ���� �� �������� ������������ ���� (':' � '\')
function PathIsFileSpec(const APath: String): Boolean;

// ���������� True, ���� ���� - �������������
function PathIsRelative(const APath: String): Boolean;

// ���������� True, ���� ���� - ����������
function PathIsAbsolute(const APath: String): Boolean;

// ��������� ������ � ������� ��� ������������� (������� ��������)
function PathQuoteSpaces(const APath: String; const AForce: Boolean = False): String;

// ��������� ������������� ���� � ATo �� (������������) AFrom (������� '\' ���������� �������)
function PathRelativePathTo(const AFrom, ATo: String): String;

// ��������� ������������� ��� � ����������, ������������� ����������� ����
function PathSearchAndQualify(const APath: String): String;

// ���������� �������� ��� �� ��������
function PathGetShortPath(const APath: String): String;

// ���������� ������� ��� �� ���������
function PathGetLFNPath(const APath: String): String;

// ���������� True, ���� ���� - ��������
function PathIsValid(const APath: String): Boolean;

// ������ ��������� ������ ��� ������� ���������. ��������� ���� ������� ����� ���������� � CreateProcess
function PathProcessCommand(const AProgram: String; const AParameters: array of String): String;
procedure GetBuildInfo(var V1, V2, V3, V4: word);
function GetBuildInfoAsString: string;
function Get_Special_Folder(const CSIDL: Integer): string;

implementation

{$A+}
{$R+}
{$Z4}
{$WARN SYMBOL_PLATFORM OFF}

uses
  Windows, SysUtils;

function Kernel32: HMODULE; forward;
function ShlwAPI: HMODULE; forward;

{$IFNDEF UNICODE}
type
  UnicodeString = WideString;
{$ENDIF}

procedure CreateBuffer(out Buffer: String; const ALen: Integer); overload;
begin
  SetLength(Buffer, ALen);
  FillChar(Pointer(Buffer)^, ALen * SizeOf(Char), 0);
end;

procedure CreateBuffer(out Buffer: String; const APath: String); overload;
begin
  CreateBuffer(Buffer, MAX_PATH);
  Move(Pointer(APath)^, Pointer(Buffer)^, Length(APath) * SizeOf(Char));
end;

{$IFNDEF UNICODE}
procedure CreateBuffer(out Buffer: UnicodeString; const ALen: Integer); overload;
begin
  SetLength(Buffer, ALen);
  FillChar(Pointer(Buffer)^, ALen * SizeOf(WideChar), 0);
end;

procedure CreateBuffer(out Buffer: UnicodeString; const APath: String); overload;
var
  Path: UnicodeString;
begin
  CreateBuffer(Buffer, MAX_PATH);
  Path := APath;
  Move(Pointer(Path)^, Pointer(Buffer)^, Length(APath) * SizeOf(WideChar));
end;
{$ENDIF}

function PathQuoteSpaces(const APath: String; const AForce: Boolean): String;
begin
  if (not AForce) and
     (Pos(' ', APath) <= 0) and
     (Pos('"', APath) <= 0) then
  begin
    Result := APath;
    Exit;
  end;

  Result := '"' + StringReplace(APath, '"', '\"', [rfReplaceAll]) + '"';
  if (Length(Result) > 2) and
     (Result[Length(Result) - 1] = '"') then
    Insert('\', Result, Length(Result) - 1);
end;

var
  FPathRelativePathTo: function(APath, AFrom: PChar; AttrFrom: DWORD; ATo: PChar; AttrTo: DWORD): BOOL; stdcall;

function PathRelativePathTo(const AFrom, ATo: String): String;
var
  Buffer, From, ToD: String;
  AttrFrom, AttrTo: DWORD;

begin
  if not Assigned(FPathRelativePathTo) then
  begin
    FPathRelativePathTo := GetProcAddress(ShlwAPI, {$IFDEF UNICODE}'PathRelativePathToW'{$ELSE}'PathRelativePathToA'{$ENDIF});
    Win32Check(Assigned(FPathRelativePathTo));
  end;

  Assert(AFrom <> '');
  Assert(ATo <> '');

  if AFrom[Length(AFrom)] = PathDelim then
    AttrFrom := FILE_ATTRIBUTE_DIRECTORY
  else
    AttrFrom := 0;
  if ATo[Length(ATo)] = PathDelim then
    AttrTo := FILE_ATTRIBUTE_DIRECTORY
  else
    AttrTo := 0;

  From := ExcludeTrailingPathDelimiter(PathCanonicalize(AFrom));
  ToD  := ExcludeTrailingPathDelimiter(PathCanonicalize(ATo));

  CreateBuffer(Buffer, MAX_PATH);
  if FPathRelativePathTo(PChar(Buffer), PChar(From), AttrFrom, PChar(ToD), AttrTo) then
    Result := PChar(Buffer)
  else
    Result := '';
end;

var
  FGetShortPathName: function(ALong, AShort: PChar; Len: Integer): Integer; stdcall;

function PathGetShortPath(const APath: String): String;
begin
  if not Assigned(FGetShortPathName) then
  begin
    FGetShortPathName := GetProcAddress(Kernel32, {$IFDEF UNICODE}'GetShortPathNameW'{$ELSE}'GetShortPathNameA'{$ENDIF});
    Win32Check(Assigned(FGetShortPathName));
  end;

  CreateBuffer(Result, 32768);
  SetLength(Result, FGetShortPathName(PChar(APath), PChar(Result), 32768));
  if Result = '' then
    Result := APath;
end;

var
  FGetLongPathName: function(AShort, ALong: PChar; Len: Integer): Integer; stdcall;

function PathGetLFNPath(const APath: String): String;
begin
  if not Assigned(FGetLongPathName) then
  begin
    FGetLongPathName := GetProcAddress(Kernel32, {$IFDEF UNICODE}'GetLongPathNameW'{$ELSE}'GetLongPathNameA'{$ENDIF});
    Win32Check(Assigned(FGetLongPathName));
  end;

  CreateBuffer(Result, 32768);
  SetLength(Result, FGetLongPathName(PChar(APath), PChar(Result), 32768));
  if Result = '' then
    Result := APath;
end;

function PathProcessCommand(const AProgram: String; const AParameters: array of String): String;
var
  X: Integer;
  Param: String;
begin
  Result := PathQuoteSpaces(AProgram);

  for X := 0 to High(AParameters) do
  begin
    if PathFileExists(AParameters[X]) then
      Param := PathQuoteSpaces({$IFDEF UNICODE}PathGetShortPath({$ENDIF}AParameters[X]{$IFDEF UNICODE}){$ENDIF})
    else
      Param := PathQuoteSpaces(AParameters[X]);
    Result := Result + ' ' + Param;
  end;
end;

function PathIsValid(const APath: String): Boolean;
const
  UNCWPrefix = '\\?';
var
  Path: String;
  I: Integer;
begin
  if APath = '' then
  begin
    Result := False;
    Exit;
  end;

  // ��� DRON � DK: ������� ��������� ���� �� ����� � ��������� ������ ����� ������� MoveFile
  // MoveFile ����� ���� OK, ���� ERROR_ALREADY_EXISTS ��� ���������� ������;
  // � ����� ������ ������ ��� ����������������� ��������, ����������������� ��� (COM, etc.), ���������������� ����������� �������� ������� ��������
  Result := False;
  Path := APath;
  repeat
    I := LastDelimiter('\/', Path);
    if (Path <> '') and
       (
         (Path[Length(Path)] = '.') or
         (Path[Length(Path)] = ' ')
       ) then
      Exit;
    MoveFile(nil, PChar(Path));
    if (GetLastError = ERROR_ALREADY_EXISTS) or
       (
         (GetFileAttributes(PChar(Copy(Path, I + 1, MaxInt))) = INVALID_FILE_ATTRIBUTES) and
         (GetLastError = ERROR_INVALID_NAME)
       ) then
      Exit;
    if I > 0 then
      Path := Copy(Path, 1, I - 1);
    if (I = 4) and (Path = UNCWPrefix) then
      I := 0;
  until I = 0;
  Result := True;
end;

function PathAppend(const APath, AMore: String): String;
var
  Path, More: String;
begin
  if AMore = '' then
  begin
    Result := APath;
    Exit;
  end;

  Path := StringReplace(APath, '/', PathDelim, [rfReplaceAll]);
  More := StringReplace(AMore, '/', PathDelim, [rfReplaceAll]);
  if More[1] = PathDelim then
    Result := ExcludeTrailingPathDelimiter(Path) + More
  else
    Result := IncludeTrailingPathDelimiter(Path) + More;
end;

function PathCombine(const APath, AMore: String): String;
begin
  Result := PathCanonicalize(PathAppend(APath, AMore));
end;

var
  FPathGetCharType: function(Ch: Char): UINT; stdcall;

function PathGetCharType(const AChar: Char): TPathCharTypes;
const
  GCT_INVALID   = 0;
  GCT_LFNCHAR   = 1;
  GCT_SHORTCHAR = 2;
  GCT_WILD      = 4;
  GCT_SEPARATOR = 8;
var
  R: UINT;
begin
  Result := [];

  if not Assigned(FPathGetCharType) then
  begin
    FPathGetCharType := GetProcAddress(ShlwAPI, {$IFDEF UNICODE}'PathGetCharTypeW'{$ELSE}'PathGetCharTypeA'{$ENDIF});
    Win32Check(Assigned(FPathGetCharType));
  end;

  R := FPathGetCharType(AChar);
  if R = GCT_INVALID then
  begin
    Result := [gctInvalid];
    Exit;
  end;

  if (R and GCT_LFNCHAR) <> 0 then
    Include(Result, gctLFNChar);
  if (R and GCT_SEPARATOR) <> 0 then
    Include(Result, gctSeparator);
  if (R and GCT_SHORTCHAR) <> 0 then
    Include(Result, gctShortChar);
  if (R and GCT_WILD) <> 0 then
    Include(Result, gctWild);
end;

var
  FPathGetDriveNumber: function(Path: PChar): Integer; stdcall;

function PathGetDriveNumber(const APath: String): TDriveNumber;
var
  R: Integer;
begin
  if not Assigned(FPathGetDriveNumber) then
  begin
    FPathGetDriveNumber := GetProcAddress(ShlwAPI, {$IFDEF UNICODE}'PathGetDriveNumberW'{$ELSE}'PathGetDriveNumberA'{$ENDIF});
    Win32Check(Assigned(FPathGetDriveNumber));
  end;

  R := FPathGetDriveNumber(PChar(APath));
  if R < 0 then
    Result := InvalidDrive
  else
    Result := TDriveNumber(R);
end;

var
  FPathBuildRoot: function(Root: PChar; I: Integer): PChar; stdcall;

function PathBuildRoot(const ADrive: TDriveNumber): String;
var
  Buffer: String;
begin
  if not Assigned(FPathBuildRoot) then
  begin
    FPathBuildRoot := GetProcAddress(ShlwAPI, {$IFDEF UNICODE}'PathBuildRootW'{$ELSE}'PathBuildRootA'{$ENDIF});
    Win32Check(Assigned(FPathBuildRoot));
  end;

  CreateBuffer(Buffer, 4);
  Result := FPathBuildRoot(PChar(Buffer), Ord(ADrive));
end;

var
  FPathCanonicalize: function(ADst, ASrc: PChar): BOOL; stdcall;

function PathCanonicalize(const APath: String): String;
var
  Buffer, Path: String;
  X: Integer;
begin
  if not Assigned(FPathCanonicalize) then
  begin
    FPathCanonicalize := GetProcAddress(ShlwAPI, {$IFDEF UNICODE}'PathCanonicalizeW'{$ELSE}'PathCanonicalizeA'{$ENDIF});
    Win32Check(Assigned(FPathCanonicalize));
  end;

  CreateBuffer(Buffer, MAX_PATH);
  Path := StringReplace(APath, '/', PathDelim, [rfReplaceAll]);
  Win32Check(FPathCanonicalize(PChar(Buffer), PChar(Path)));
  Result := PChar(Buffer);

  // Remove double '\'
  for X := Length(Result) downto 3 do
    if (Result[X] = PathDelim) and
       (Result[X - 1] = PathDelim) then
      Delete(Result, X, 1);
end;

var
  FPathSearchAndQualify: function(APath, AFullyQualifiedPath: PChar; Len: UINT): BOOL; stdcall;

function PathSearchAndQualify(const APath: String): String;
var
  Buffer: String;
begin
  if not Assigned(FPathSearchAndQualify) then
  begin
    FPathSearchAndQualify := GetProcAddress(ShlwAPI, {$IFDEF UNICODE}'PathSearchAndQualifyW'{$ELSE}'PathSearchAndQualifyA'{$ENDIF});
    Win32Check(Assigned(FPathSearchAndQualify));
  end;

  CreateBuffer(Buffer, MAX_PATH);
  Win32Check(FPathSearchAndQualify(PChar(APath), PChar(Buffer), MAX_PATH));
  Result := PChar(Buffer);
end;

var
  FPathFileExists: function(Path: PChar): BOOL; stdcall;

function PathFileExists(const APath: String): Boolean;
begin
  if not Assigned(FPathFileExists) then
  begin
    FPathFileExists := GetProcAddress(ShlwAPI, {$IFDEF UNICODE}'PathFileExistsW'{$ELSE}'PathFileExistsA'{$ENDIF});
    Win32Check(Assigned(FPathFileExists));
  end;

  Result := FPathFileExists(PChar(APath));
end;

var
  FPathIsDirectory: function(Path: PChar): UINT; stdcall;

function PathIsDirectory(const APath: String): Boolean;
begin
  if not Assigned(FPathIsDirectory) then
  begin
    FPathIsDirectory := GetProcAddress(ShlwAPI, {$IFDEF UNICODE}'PathIsDirectoryW'{$ELSE}'PathIsDirectoryA'{$ENDIF});
    Win32Check(Assigned(FPathIsDirectory));
  end;

  Result := FPathIsDirectory(PChar(APath)) <> 0;
end;

var
  FPathIsFileSpec: function(Path: PChar): BOOL; stdcall;

function PathIsFileSpec(const APath: String): Boolean;
begin
  if not Assigned(FPathIsFileSpec) then
  begin
    FPathIsFileSpec := GetProcAddress(ShlwAPI, {$IFDEF UNICODE}'PathIsFileSpecW'{$ELSE}'PathIsFileSpecA'{$ENDIF});
    Win32Check(Assigned(FPathIsFileSpec));
  end;

  Result := FPathIsFileSpec(PChar(APath));
end;

var
  FPathIsRelative: function(Path: PChar): BOOL; stdcall;

function PathIsRelative(const APath: String): Boolean;
var
  X: Integer;
begin
  // http://stackoverflow.com/questions/26099361/is-it-a-winapi-bug-with-pathisrelative-function
  X := Pos(':', APath);
   if (X > 0) and
     (X < Length(APath)) and
     (APath[X + 1] <> PathDelim) and
     (APath[X + 1] <> '/') then
  begin
    Result := True;
    Exit;
  end;

  if not Assigned(FPathIsRelative) then
  begin
    FPathIsRelative := GetProcAddress(ShlwAPI, {$IFDEF UNICODE}'PathIsRelativeW'{$ELSE}'PathIsRelativeA'{$ENDIF});
    Win32Check(Assigned(FPathIsRelative));
  end;

  Result := FPathIsRelative(PChar(APath));
end;

function PathIsAbsolute(const APath: String): Boolean;
begin
  Result := not PathIsRelative(APath);
end;

var
  FKernelLib: HMODULE;
  FShlwAPILib: HMODULE;

function Kernel32: HMODULE;
const
  DLLName = 'kernel32.dll';
begin
  if FKernelLib = 0 then
  begin
    FKernelLib := LoadLibrary(DLLName);
    Win32Check(FKernelLib <> 0);
  end;
  Result := FKernelLib;
end;

function ShlwAPI: HMODULE;
const
  DLLName = 'shlwapi.dll';
begin
  if FShlwAPILib = 0 then
  begin
    FShlwAPILib := LoadLibrary(DLLName);
    Win32Check(FShlwAPILib <> 0);
  end;
  Result := FShlwAPILib;
end;

procedure GetBuildInfo(var V1, V2, V3, V4: word);
var
  VerInfoSize, VerValueSize, Dummy: DWORD;
  VerInfo: Pointer;
  VerValue: PVSFixedFileInfo;
begin
  VerInfoSize := GetFileVersionInfoSize(PChar(ParamStr(0)), Dummy);
  if VerInfoSize > 0 then
  begin
      GetMem(VerInfo, VerInfoSize);
      try
        if GetFileVersionInfo(PChar(ParamStr(0)), 0, VerInfoSize, VerInfo) then
        begin
          VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
          with VerValue^ do
          begin
            V1 := dwFileVersionMS shr 16;
            V2 := dwFileVersionMS and $FFFF;
            V3 := dwFileVersionLS shr 16;
            V4 := dwFileVersionLS and $FFFF;
          end;
        end;
      finally
        FreeMem(VerInfo, VerInfoSize);
      end;
  end;
end;

function GetBuildInfoAsString: string;
var
  V1, V2, V3, V4: word;
begin
  GetBuildInfo(V1, V2, V3, V4);
  Result := IntToStr(V1) + '.' + IntToStr(V2) + '.' +
    IntToStr(V3) + '.' + IntToStr(V4);
end;

function Get_Special_Folder(const CSIDL: Integer): string;
var
  ShellMalloc: IMalloc;
  ItemIDList: PItemIDList;
  Buffer: PChar;
begin
  Result := '';
  if (ShGetMalloc(ShellMalloc) = S_OK) and (ShellMalloc <> nil) then
  begin
    Buffer := ShellMalloc.Alloc(MAXPATHLEN + 1);
    try
      if Succeeded(SHGetSpecialFolderLocation(0, CSIDL, ItemIDList)) then
      begin
        ShGetPathFromIDList(ItemIDList, Buffer);
        ShellMalloc.Free(ItemIDList);
        Result := Buffer;
      end;
    finally
      ShellMalloc.Free(Buffer);
    end;
  end;
end;


end.

