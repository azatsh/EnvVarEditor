unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Registry, StdCtrls;

type
  TForm1 = class(TForm)
    VarList: TListBox;
    btnChange: TButton;
    ValEdit: TEdit;
    btnAdd: TButton;
    ValList: TListBox;
    btnDelete: TButton;
    procedure VarListClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnChangeClick(Sender: TObject);
    procedure ValListClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    function RegistryInit(): TRegistry;
    procedure ReadVars();
    procedure SaveVar(Name, Value: String);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function TForm1.RegistryInit(): TRegistry;
begin
  Result := TRegistry.Create;
  Result.RootKey := HKEY_LOCAL_MACHINE;
  Result.OpenKey('System\CurrentControlSet\Control\Session Manager\Environment', False);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ReadVars();
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  with VarList do
  begin
    Left := 10;
    Top := 10;
    Width := Trunc(Self.ClientWidth * 0.3);
    Height := Self.ClientHeight - Top - 10;
  end;

  with ValList do
  begin
    Left := VarList.Left + VarList.Width + 10;
    Top := 10;
    Width := Self.ClientWidth - Left - 10;
    Height := Self.ClientHeight - Top - 80;
  end;

  ValEdit.Left := ValList.Left;
  ValEdit.Top := ValList.Top + ValList.Height + 10;
  ValEdit.Width := Self.ClientWidth - ValEdit.Left - 10;

  btnChange.Left := ValEdit.Left;
  btnChange.Top := ValEdit.Top + ValEdit.Height + 10;
  btnAdd.Left := btnChange.Left + btnChange.Width + 5;
  btnAdd.Top := ValEdit.Top + ValEdit.Height + 10;
  btnDelete.Left := btnAdd.Left + btnAdd.Width + 5;
  btnDelete.Top := ValEdit.Top + ValEdit.Height + 10;
end;

procedure TForm1.ValListClick(Sender: TObject);
var
  Index: Integer;
begin
  Index := (Sender as TListBox).ItemIndex;
  if (Index >= 0) then
    ValEdit.Text := (Sender as TListBox).Items[Index];
end;

procedure TForm1.VarListClick(Sender: TObject);
var
  R: TRegistry;
  Name,Value: string;
begin
  Name := VarList.Items[VarList.ItemIndex];
  R := RegistryInit();

  Value := R.ReadString(Name);

  ValList.Items.Clear;
  ValList.Items.Delimiter := ';';
  ValList.Items.QuoteChar := '"';
  ValList.Items.StrictDelimiter := true;
  ValList.Items.DelimitedText := Value;

  R.Free;
end;

procedure TForm1.ReadVars();
var
  R: TRegistry;
  Keys: TStrings;
begin
  R := RegistryInit();
  R.GetValueNames(VarList.Items);
  R.Free;
end;

procedure TForm1.SaveVar(Name, Value: String);
var
  R: TRegistry;
begin
  R := RegistryInit();
  R.WriteString(Name, Value);
  R.Free;
end;

procedure TForm1.btnAddClick(Sender: TObject);
var
  Name,Value: string;
begin
  Value := ValEdit.Text;
  if (Value <> '') then
  begin
    ValList.Items.Add(Value);
    SaveVar(VarList.Items[VarList.ItemIndex], ValList.Items.DelimitedText);
  end;
end;

procedure TForm1.btnChangeClick(Sender: TObject);
var
  Value: string;
begin
  Value := ValEdit.Text;
  if (Value <> '') and (ValList.ItemIndex >= 0) then
  begin
    ValList.Items[ValList.ItemIndex] := Value;
    SaveVar(VarList.Items[VarList.ItemIndex], ValList.Items.DelimitedText);
  end;
end;

procedure TForm1.btnDeleteClick(Sender: TObject);
begin
  if (ValList.ItemIndex >= 0) then
  begin
    ValList.Items.Delete(ValList.ItemIndex);
    SaveVar(VarList.Items[VarList.ItemIndex], ValList.Items.DelimitedText);
  end;
end;

end.
