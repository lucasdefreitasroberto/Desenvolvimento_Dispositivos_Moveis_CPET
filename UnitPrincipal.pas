unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  FMX.TextLayout, FMX.Edit, FMX.Ani, System.Math.Vectors, FMX.Controls3D,
  FMX.Layers3D;

type
  TFrmPrincipal = class(TForm)
    Layout1: TLayout;
    imgVoltar: TImage;
    Label1: TLabel;
    Layout2: TLayout;
    Circle1: TCircle;
    Label2: TLabel;
    lvChat: TListView;
    Layout3: TLayout;
    imgFundo: TImage;
    StyleBook1: TStyleBook;
    btnEnviar: TSpeedButton;
    Layout3D1: TLayout3D;


  private

    procedure LayoutLv(item: TListViewItem);

    function GetTextHeight(const D: TListItemText; const Width: single;
      const Text: string): Integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

function TFrmPrincipal.GetTextHeight(const D: TListItemText; const Width: single; const Text: string): Integer;
var
  Layout: TTextLayout;
begin
  Layout := TTextLayoutManager.DefaultTextLayout.Create;
  try
    Layout.BeginUpdate;
    try
      Layout.Font.Assign(D.Font);
      Layout.VerticalAlign := D.TextVertAlign;
      Layout.HorizontalAlign := D.TextAlign;
      Layout.WordWrap := D.WordWrap;
      Layout.Trimming := D.Trimming;
      Layout.MaxSize := TPointF.Create(Width, TTextLayout.MaxLayoutSize.Y);
      Layout.Text := Text;
    finally
      Layout.EndUpdate;
    end;

    Result := Round(Layout.Height);

    Layout.Text := 'm';
    Result := Result + Round(Layout.Height);
  finally
    Layout.Free;
  end;
end;

procedure TFrmPrincipal.LayoutLv(item: TListViewItem);
var
    img: TListItemImage;
    txt: TListItemText;
begin
    // Posiciona o texto...
    txt := TListItemText(item.Objects.FindDrawable('txtMsg'));
    txt.Width := lvChat.Width / 2 - 16;
    txt.PlaceOffset.X := 20;
    txt.PlaceOffset.Y := 10;
    txt.Height := GetTextHeight(txt, txt.Width, txt.Text);
    txt.TextColor := $FF000000;

    // Balao msg...
    img := TListItemImage(item.Objects.FindDrawable('imgFundo'));
    img.Width := lvChat.Width / 2;
    img.PlaceOffset.X := 10;
    img.PlaceOffset.Y := 10;
    img.Height := txt.Height;
    img.Opacity := 0.1;

    if txt.Height < 40 then
        img.Width := Trunc(txt.Text.Length * 8);

    // Data...
    txt := TListItemText(item.Objects.FindDrawable('txtData'));
    txt.PlaceOffset.X := img.PlaceOffset.X + img.Width - 100;
    txt.PlaceOffset.Y := img.PlaceOffset.Y + img.Height + 2;

    // Altura do item da Lv...
    item.Height := Trunc(img.PlaceOffset.Y + img.Height + 30);
end;



end.
