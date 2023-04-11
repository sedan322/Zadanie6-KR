unit Unit1;

{$mode objfpc}{$H+}

interface

uses
Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

{ TForm1 }

TForm1 = class(TForm)
btnCalculate: TButton;
CheckBox1: TCheckBox;
CheckBox2: TCheckBox;
chkCompoundInterest: TCheckBox;
chkSimpleInterest: TCheckBox;
edtDepositAmount: TEdit;
edtDuration: TEdit;
edtInterestRate: TEdit;
lblDepositAmount: TLabel;
lblDuration: TLabel;
lblInterestRate: TLabel;

memOutput: TMemo;
procedure btnCalculateClick(Sender: TObject);
procedure chkSimpleInterestChange(Sender: TObject);
procedure chkCompoundInterestChange(Sender: TObject);
private
{ private declarations }
public
{ public declarations }
end;

var
Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.btnCalculateClick(Sender: TObject);
var
depositAmount, interestRate, interest, totalInterest: Double;
duration, i: Integer;
begin
// Получаем входные данные
depositAmount := StrToFloat(edtDepositAmount.Text);
duration := StrToInt(edtDuration.Text);
interestRate := StrToFloat(edtInterestRate.Text);

// Проверяем, выбран ли тип начисления простых процентов
if chkSimpleInterest.Checked then
begin
interest := depositAmount * interestRate / 100 * duration / 12;
totalInterest := interest;
end
// Иначе выбран тип начисления сложных процентов
else if chkCompoundInterest.Checked then
begin
totalInterest := 0;
for i := 1 to duration do
begin
interest := (depositAmount + totalInterest) * interestRate / 100 / 12;
totalInterest := totalInterest + interest;
end;
end;

// Выводим результаты на экран
memOutput.Lines.Clear;
memOutput.Lines.Add('Сумма вклада: ' + FormatFloat('#,##0.00', depositAmount) + ' руб.');
memOutput.Lines.Add('Процентная ставка: ' + FormatFloat('0.00', interestRate) + '%');
memOutput.Lines.Add('Срок вклада: ' + IntToStr(duration) + ' мес.');
memOutput.Lines.Add('');
memOutput.Lines.Add('Доход:');
memOutput.Lines.Add(Format('%-25s %10s', ['Простые проценты:', FormatFloat('#,##0.00', interest)]));
memOutput.Lines.Add(Format('%-25s %10s', ['Сложные проценты:', FormatFloat('#,##0.00', totalInterest)]));
end;

procedure TForm1.chkSimpleInterestChange(Sender: TObject);
begin
if chkSimpleInterest.Checked then
chkCompoundInterest.Checked := False;
end;

procedure TForm1.chkCompoundInterestChange(Sender: TObject);
begin
if chkCompoundInterest.Checked then
chkSimpleInterest.Checked := False;
end;

end.

