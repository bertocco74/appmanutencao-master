unit Threads;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TfThreads = class(TForm)
    Memo1: TMemo;
    edtQtd: TEdit;
    edtSleep: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    btnListar: TButton;
    ProgressBar1: TProgressBar;
    procedure btnListarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fThreads: TfThreads;
  qtd,Time: Integer;
implementation

{$R *.dfm}

procedure UpdateFromThreadViaQueue;
var
  i: integer;
begin
  for i := 0 to qtd + 1 do begin
    Sleep(Random(time));
    TThread.Queue(nil,
      procedure begin
        fThreads.ProgressBar1.Position := i;
        fThreads.memo1.Lines.add(inttostr(i) + ' - Processamento finalizado ');
      end);
      if fThreads.Memo1.Lines.Count =  qtd + 2 then
        exit;
        fThreads.memo1.Lines.Add(inttostr(i) + ' - Iniciando processamento');
        fThreads.memo1.Lines.Delete(i);
  end;
end;




procedure TfThreads.btnListarClick(Sender: TObject);
begin
    qtd:=strtoint(edtqtd.Text);
    Time:=strtoint(edtSleep.Text);
    TThread.CreateAnonymousThread(UpdateFromThreadViaQueue).Start;
end;

procedure TfThreads.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 FreeAndNil(fThreads);
end;

procedure TfThreads.FormShow(Sender: TObject);
begin
edtqtd.SetFocus;
end;

end.
