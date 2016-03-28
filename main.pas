unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, PrintersDlgs, Forms, Controls, Graphics, Dialogs,
  Menus, Grids, About;

type

  { TfMian }

  TfMian = class(TForm)
    FD: TFontDialog;
    MainMenu1: TMainMenu;
    mBeginSerch: TMenuItem;
    mAbout: TMenuItem;
    mSort04: TMenuItem;
    mSort03: TMenuItem;
    mSort01: TMenuItem;
    mSort02: TMenuItem;
    mSort00: TMenuItem;
    mShrift: TMenuItem;
    mVid: TMenuItem;
    mSpravka: TMenuItem;
    mSearch: TMenuItem;
    mExit: TMenuItem;
    mFile: TMenuItem;
    StringGrid1: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure mAboutClick(Sender: TObject);
    procedure mBeginSerchClick(Sender: TObject);
    procedure mExitClick(Sender: TObject);
    procedure mShriftClick(Sender: TObject);
    procedure mSort00Click(Sender: TObject);
    procedure mSort01Click(Sender: TObject);
    procedure mSort02Click(Sender: TObject);
    procedure mSort03Click(Sender: TObject);
    procedure mSort04Click(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fMian: TfMian;
     FolderProgramm: TextFile;   // для хранения адресов
     NameProgramm: TextFile; // Названия, только для отображения
     Rasprost: TextFile;
     License: TextFile;
     Stoimost: TextFile;
     Zamena: TextFile;
implementation

{$R *.lfm}

{ TfMian }

procedure TfMian.mExitClick(Sender: TObject);
begin
  Close;
end;





procedure TfMian.mShriftClick(Sender: TObject);
begin
    //сначала диалогу присваиваем шрифт как у Memo:
  FD.Font:= StringGrid1.Font;
  //если диалог прошел успешно, меняем шрифт у Memo:
  if FD.Execute then StringGrid1.Font:= FD.Font;
end;

procedure TfMian.mSort00Click(Sender: TObject);
begin
  StringGrid1.SortColRow(true, 0);
end;

procedure TfMian.mSort01Click(Sender: TObject);
begin
  StringGrid1.SortColRow(true, 1);
end;

procedure TfMian.mSort02Click(Sender: TObject);
begin
  StringGrid1.SortColRow(true, 2);
end;

procedure TfMian.mSort03Click(Sender: TObject);
begin
  StringGrid1.SortColRow(true, 3);
end;

procedure TfMian.mSort04Click(Sender: TObject);
begin
  StringGrid1.SortColRow(true, 4);
end;

procedure TfMian.StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
  aRect: TRect; aState: TGridDrawState);
var
p : integer;
begin
for p := 1 to StringGrid1.RowCount-1 do
begin
if StringGrid1.Cells[1,p] = 'Free Software' then
begin
if arow = p then
begin
//StringGrid1.Canvas.Brush.Color := clGreen;
StringGrid1.Canvas.Font.Color:=clGreen;
StringGrid1.Canvas.Font.Style:=Font.Style+[fsBold];
StringGrid1.Canvas.FillRect(aRect);
StringGrid1.Canvas.TextOut(aRect.Left, aRect.Top, StringGrid1.Cells[ACol, ARow]);
end;
end
end;   // вторая отрисовка условно бесплатное

for p := 1 to StringGrid1.RowCount-1 do
begin
if StringGrid1.Cells[1,p] = 'Freeware' then
begin
if arow = p then
begin
//StringGrid1.Canvas.Brush.Color := clYellow;
StringGrid1.Canvas.Font.Color:=$000E41AB;
StringGrid1.Canvas.Font.Style:=Font.Style+[fsBold];
StringGrid1.Canvas.FillRect(aRect);
StringGrid1.Canvas.TextOut(aRect.Left, aRect.Top, StringGrid1.Cells[ACol, ARow]);
end;
end
end;       // далее платное ПО

for p := 1 to StringGrid1.RowCount-1 do
begin
if StringGrid1.Cells[1,p] = 'Shareware' then
begin
if arow = p then
begin
//StringGrid1.Canvas.Brush.Color := clRed;
StringGrid1.Canvas.Font.Color:=clRed;
StringGrid1.Canvas.Font.Style:=Font.Style+[fsBold];
StringGrid1.Canvas.FillRect(aRect);
StringGrid1.Canvas.TextOut(aRect.Left, aRect.Top, StringGrid1.Cells[ACol, ARow]);
end;
end
end;

end;

procedure TfMian.mBeginSerchClick(Sender: TObject);
var
     s: string;   // читаем из FolderProgramm в s
     d: string;   // читаем из NameProgramm в d
     f: string;   // читаем из Rasprost
     g: string;   // читаем из License
     h: string;  // читаем из Stoimost
     j: string;  // читаем из Zamena
     i: integer; // для заполнения данных
//     x: Boolean;
begin
   try
      AssignFile(FolderProgramm, 'FolderProgramm.txt'); //связали файловую переменную с файлом
      Reset(FolderProgramm); //открыли файл для чтения, указатель в начале файла
      AssignFile(NameProgramm, UTF8ToSys('NameProgramm.txt'));
      Reset(NameProgramm);
      AssignFile(Rasprost, UTF8ToSys('Rasprost.txt'));
      Reset(Rasprost);
      AssignFile(License, UTF8ToSys('License.txt'));
      Reset(License);
      AssignFile(Stoimost, UTF8ToSys('Stoimost.txt'));
      Reset(Stoimost);
      AssignFile(Zamena, UTF8ToSys('Zamena.txt'));
      Reset(Zamena);
          //делаем, пока не конец файла:
          while not Eof(FolderProgramm) do begin
            Cursor:= crHourGlass;
            Readln(FolderProgramm, s); //читаем в s очередную строку
            Readln(NameProgramm, d); //читаем в d очередную строку
            Readln(Rasprost, f); //читаем в f очередную строку
            Readln(License, g);
            Readln(Stoimost, h);
            Readln(Zamena, j);
              if not DirectoryExists(s) then continue
              else begin
                 // далее нужно записать что нашли
                 StringGrid1.RowCount:= StringGrid1.RowCount + 1;
                 i:= StringGrid1.RowCount;
                 SetLength(d, (i * 15));
                 StringGrid1.Cells[0, StringGrid1.RowCount-1]:= d;
                 //               if f = 'Свободная программа' then
                 //               StringGrid1.AlternateColor:=ClGreen;// color
                 StringGrid1.Cells[1, StringGrid1.RowCount-1]:= f;
                 StringGrid1.Cells[2, StringGrid1.RowCount-1]:= g;
                 StringGrid1.Cells[3, StringGrid1.RowCount-1]:= h;
                 StringGrid1.Cells[4, StringGrid1.RowCount-1]:= j;
              end;
              end;
     //     x:=true;
    //      StringGrid1.SortColRow(true, 1);
   finally
      CloseFile(FolderProgramm);  //по окончании закрываем файл
      CloseFile(NameProgramm);
      CloseFile(Rasprost);
      CloseFile(License);
      CloseFile(Stoimost);
      CloseFile(Zamena);
      Cursor:= crDefault;
   end;  //try

end;

procedure TfMian.FormCreate(Sender: TObject);
begin
  //заполняем заголовки колонок:
  StringGrid1.Cells[0, 0]:= 'Name';
  StringGrid1.Cells[1, 0]:= 'Type of software';
  StringGrid1.Cells[2, 0]:= 'License';
  StringGrid1.Cells[3, 0]:= 'Cost';
  StringGrid1.Cells[4, 0]:= 'Replacement';
  //меняем ширину колонок:
  StringGrid1.ColWidths[0]:= 200;
  StringGrid1.ColWidths[1]:= 150;
  StringGrid1.ColWidths[2]:= 110;
  StringGrid1.ColWidths[3]:= 90;
  StringGrid1.ColWidths[4]:= 150;
end;

procedure TfMian.mAboutClick(Sender: TObject);
begin
  fAbout.ShowModal;
end;

end.
