; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "Rocket Word Study"
#define MyAppPublisher "Rocket Technologies"
#define MyAppURL "https://rockettech.com/rws"
#define MyAppExeName "rws.exe"
#define MyAppVersion GetVersionNumbersString(MyAppExeName)
#define WorkDir "{commondocs}\"+MyAppPublisher+"\"+MyAppName 
#define DEBUG "0.0.0.0"
#define SoundLibUS "English(US)\*"
#define SoundLibUK "English(UK)\*"
#define IncludeSoundLib
#define Dictionaries "Dictionaries\*"

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{B0562CCF-CCE7-4F3C-A55A-581B58046B64}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppPublisher}\{#MyAppName}
DisableProgramGroupPage=yes
; Uncomment the following line to run in non administrative install mode (install for current user only.)
;PrivilegesRequired=lowest
PrivilegesRequiredOverridesAllowed=commandline
OutputDir=Release
OutputBaseFilename=rws_install
SetupIconFile=rocket-64x64.ico
Compression=lzma
SolidCompression=yes
WizardStyle=modern
UninstallDisplayIcon={app}\rws.exe
VersionInfoProductName={#MyAppName}
VersionInfoVersion={#MyAppVersion}
VersionInfoDescription={#MyAppName}
UninstallDisplayName={#MyAppName}
AppCopyright=Copyright � {#MyAppPublisher} 2023

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Dirs]

Name: "{#WorkDir}"; Flags: uninsalwaysuninstall; Permissions: users-modify

[Files]
Source: "{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion

#if (GetVersionNumbersString(MyAppExeName) == DEBUG)
  #error Program version is a debug version
#endif

Source: "db\rws.db"; DestDir: "{#WorkDir}"; Flags: ignoreversion
Source: "*.dll"; DestDir: "{app}"; Flags: ignoreversion

Source: "{#Dictionaries}"; DestDir: "{app}\Dictionaries"; Flags: ignoreversion recursesubdirs createallsubdirs
  
#ifdef IncludeSoundLib 
Source: "{#SoundLibUS}"; DestDir: "{app}\English(US)"; Flags: ignoreversion recursesubdirs createallsubdirs
//Source: "{#SoundLibUK}"; DestDir: "{app}\English(UK)"; Flags: ignoreversion recursesubdirs createallsubdirs
#else
#pragma warning "Sound library path is turned off"
#endif



Source: "phontm.ttf"; DestDir: "{autofonts}"; FontInstall: "PhoneticTM"; Flags: onlyifdoesntexist uninsneveruninstall

[Registry]
Root: HKLM; SubKey: SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts; ValueType: string; ValueName: PhoneticTM; ValueData: {win}\fonts; Flags: createvalueifdoesntexist 


[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent
