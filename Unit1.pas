unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, Xml.xmldom,
  Xml.XMLIntf, Xml.XMLDoc, FMX.ScrollBox, FMX.Memo, FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.ListView, FMX.Objects;

type
  TMainForm = class(TForm)
    Button1: TButton;
    XMLDoc: TXMLDocument;
    LV: TListView;
    FDMemTable1: TFDMemTable;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    StyleBook1: TStyleBook;
    ToolBar1: TToolBar;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Label1: TLabel;
    LinkListControlToField1: TLinkListControlToField;
    URLLabel: TLabel;
    LinkPropertyToFieldText: TLinkPropertyToField;
    procedure Button1Click(Sender: TObject);
    procedure LVItemClickEx(const Sender: TObject; ItemIndex: Integer;
      const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

uses
  u_urlOpen;

procedure TMainForm.Button1Click(Sender: TObject);
var
   StartItemNode : IXMLNode;
   ANode : IXMLNode;
   sTitle, sDesc, sLink : WideString;
begin

  //points to local XML file in "original" code
  XMLDoc.FileName := 'https://en.delphipraxis.net/discover/39.xml/?member=270&key=f58c3748db580ee76277d97e673afac9';
  XMLDoc.Active:=True;
  StartItemNode := XMLDoc.DocumentElement.ChildNodes.First.ChildNodes.FindNode('item') ;
  ANode := StartItemNode;
  repeat
    sTitle := ANode.ChildNodes['title'].Text;
    sLink := ANode.ChildNodes['link'].Text;
    sDesc := ANode.ChildNodes['description'].Text;
    FDMemTable1.AppendRecord([sTitle,sLink,sDesc]);

    ANode := ANode.NextSibling;
  until ANode = nil;

  LinkListControlToField1.Active := False;
  LinkListControlToField1.Active := True;
end;

procedure TMainForm.LVItemClickEx(const Sender: TObject; ItemIndex: Integer;
  const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
begin
tUrlOpen.Open(URLLabel.Text);
end;

end.
