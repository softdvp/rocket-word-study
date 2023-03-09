unit JvFillintf5;
{$I JVCL.INC}
interface
uses
  Windows, {$IFDEF COMPILER6_UP}Controls{$ELSE}ImgList{$ENDIF}, Classes, Graphics;

type
  TJvFillerChangeReason = (frAdd,     // an item is added
                           frDelete,  // an item is removed
                           frUpdate,  // the entire list is updated
                           frDestroy //  the IFiller implementor is being destroyed, clients should call UnRegisterChangeNotify and remove the reference to Filler
                           );

  TJvFillerSupport = (fsText,       // supports IFillerItemText
                      fsImages,     // supports IFillerItemImages
                      fsImageIndex, // supports IFillerItemImage
                      fsReadOnly,   // does *not* support IFillerItemManagment
                      fsCanRender,  // can render it's content to a DC
                      fsCanMeasure, // can measure the size of it's content
                      fsSubItems    // supports IFillerSubItems
                      );

  TJvFillerSupports = set of TJvFillerSupport;

  // forward
  IFillerNotify = interface;


  { base item interface: supports nothing }
  IFillerItem = interface
  ['{C965CF64-A1F2-44A4-B856-3A4EC6B693E1}']
  end;

  IBaseFiller = interface
  ['{74CEA49B-87CF-4D9F-9633-A5138ECF8F71}']
    procedure RegisterChangeNotify(AFillerNotify: IFillerNotify);
    procedure UnRegisterChangeNotify(AFillerNotify: IFillerNotify);
  end;

  { base interface for components that supports storing lists of data (0..M items) }
  IFiller = interface(IBaseFiller)
  ['{62A7A17D-1E21-427E-861D-C92FBB9B09A6}']
    procedure DrawItem(ACanvas:TCanvas; var ARect: TRect; Index: integer;State: TOwnerDrawState);
    function MeasureItem(ACanvas:TCanvas; Index: integer): TSize;
    function getCount: integer;
    function getItem(Index: integer): IFillerItem;
    function getSupports:TJvFillerSupports;

    property Items[Index: integer]: IFillerItem read getItem; default;
    property Count:integer read getCount;
  end;

  { Implemented by consumers (i.e list/comboboxes, labels, buttons, edits, listviews, treeviews, menus etc)
   to get notifications from IFiller }
  IFillerNotify = interface
  ['{5B9D1847-6D35-4D9C-8BC2-2054997AB120}']
    procedure FillerChanging(const AFiller: IFiller; AReason: TJvFillerChangeReason);
    procedure FillerChanged(const AFiller: IFiller; AReason: TJvFillerChangeReason);
  end;

  { base search interface. Supported by both IFiller and IFillerSubItems implementers if the
    implementation needs it.

    The basic idea is to declare additional interfaces to implement searching on other properties
    as well. eg. for the color filler:

      IFillerColorSearch = interface
        function IndexOfTColor(Color: TColor; const Recursive: Boolean = False): Integer;
      end;

    Both IFiller and IFillerSubItems implement those search interface that apply for the implementation.
    The recursive parameter has a default parameter value so it could be left out. }

  IFillerTextSearch = interface
  ['{E3BC388D-50F6-402D-9E30-36D5F7F40616}']
    function IndexOfText(Text: string; const Recursive: Boolean = False): Integer;
  end;

  { only supported for none autofillers. Supported by IFiller and IFillerSubItems implementers. }
  IFillerItemManagment = interface
  ['{76611CC0-9DCD-4394-8B6E-1ADEF1942BC3}']
    function Add: IFillerItem;
    procedure Clear;
    procedure Delete(Index: Integer);
    procedure Remove(Item: IFillerItem);
  end;

  { only supported when fsImages is in  IFiller.FillerSupports; supported by either IFiller or IFillerSubItems implementers. }
  IFillerItemImages = interface
  ['{735755A6-AD11-460C-B985-46464D73EDBC}']
    function getImageList: TImageList;
    procedure setImageList(const Value: TImageList);
    property ImageList: TImageList read getImageList write setImageList;
  end;

  { only supported when fsText is in IFiller.FillerSupports; supported by the IFillerItem implementer }
  IFillerItemText = interface
  ['{94FA56D9-281B-4252-B46D-15E7BADA70DA}']
    function getCaption: string;
    procedure setCaption(const Value: string);
    property Caption: string read getCaption write setCaption;
  end;

  { only supported when fsImageIndex is in IFiller.FillerSupports; supported by the IFillerItem implementer. }
  IFillerItemImage = interface
  ['{6425D73A-90CF-42ED-9AB2-63125A4C0774}']
    function getAlignment: TAlignment;
    procedure setAlignment(Value: TAlignment);
    function getImageIndex: integer;
    procedure setImageIndex(Index: integer);
    function getSelectedIndex: integer;
    procedure setSelectedIndex(Value: integer);

    property Alignment: TAlignment read getAlignment write setAlignment;
    property ImageIndex: Integer read getImageIndex write setImageIndex;
    property SelectedIndex: Integer read getSelectedIndex write setSelectedIndex;
  end;

  { only supported when fsSubItems is in IFiller.FillerSupports. Supported by the IFillerItem implementer. }
  IFillerSubItems = interface
  ['{93747660-24FB-4294-BF4E-C7F88EA23983}']
    function getCount: Integer;
    function getItem(I: Integer): IFillerItem;
    function GetParent: IFillerItem;
    property Items[Index:integer]:IFillerItem read getItem;default;
  end;

implementation

end.

