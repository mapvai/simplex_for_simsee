(*testSimplexGPUs.lpr*)
setSeparadoresGlobales;
// spx := TMIPSimplex.CreateFromArchiXLT(ParamStr(1));
spx := TMIPSimplex.CreateFromArchiXLT('EjemploExtraGrande.xlt');
spx.DumpSistemaToPlainTableForGPUs('EjemploExtraGrandeForGPUs.txt');
setSeparadoresLocales;
spx.resolver;
spx.DumpSistemaToXLT_('EjemploExtraGrandeResuelto.xlt','');
spx.Free;

(*umipsimplex.pas*)

TSimplexGPUs = TDAofNReal;

TDAOfSimplexGPUs = array of TSimplexGPUs; 
  
function TMIPSimplex.toStruct: TSimplexGPUs;
var
  NVariables, NRestricciones, i, j: Integer;
  cantcotasup, cantColumnas, cantFilas, cantVars: Integer;
  tabloide: TSimplexGPUs;
begin
  cantcotasup := 0;

  NVariables := nc - 1;
  NRestricciones := nf - 1;
  writeln( 'NVariables: ', NVariables);
  writeln( 'NRestricciones: ', NRestricciones);

  for j := 1 to NVariables do
  begin
       if (flg_x[j] > 0) then
          cantcotasup := cantcotasup + 1;
  end;

  cantVars :=  NVariables + cantcotasup;

  for i := 1 to NRestricciones do
  begin
       if (flg_y[i] = 0) then
       begin
          if (self.e(i, nc) <= 0) then
          begin
             cantVars := cantVars + 2;
          end
          else
          begin
             cantVars := cantVars + 1;
          end;
       end
       else
       begin
           cantVars := cantVars + 1;
       end;
  end;

  cantColumnas := 4 + cantVars;
  cantFilas := 6 + NRestricciones + cantcotasup;

  SetLength(tabloide, cantFilas*cantColumnas);
  (*
  writeln('cantcotasup :', cantcotasup);
  writeln('cantColumnas :', cantColumnas);
  writeln('cantFilas :', cantFilas);
  writeln('cantVars :', cantVars);
  *)
  
  //cargo matriz con ceros
  for i:= 0 to cantColumnas * cantFilas  do
	tabloide[i] := 0;

  //cargo los primeros 2 lugares de la matriz y funcion z a primera fila en la matriz
  tabloide[0]:= NVariables;
  tabloide[1]:= NRestricciones;
  tabloide[2]:= cantColumnas;
  tabloide[cantColumnas]:= cantVars;
  tabloide[cantColumnas + 1]:= NRestricciones + cantcotasup;

  // Cargo z
  for j:= 1 to NVariables do
      tabloide[j + 3] := e(nf, j);

  for j := 0 to NVariables -1 do
  begin
      tabloide[cantColumnas + j + 4] := flg_x[j + 1]; // Cargo en segunda fila flg_x
      tabloide[2*cantColumnas + j + 4] := self.x_sup.pv[j + 1]; // Cargo en tercera fila x_sup
      tabloide[3*cantColumnas + j + 4]:= self.x_inf.pv[j + 1];
  end;

  // Cargo Restricciones
  for i := 0 to NRestricciones - 1  do
  begin
    tabloide[(i + 6)*cantColumnas + 1]:= flg_y[i + 1]; // Cargo columna flag_y
    tabloide[(i + 6)*cantColumnas + 3]:= -e(i + 1 , nc); // Cargo Xb
    for j:= 0 to NVariables -1 do
        tabloide[(i + 6)*cantColumnas + j + 4] := e(i + 1 , j + 1);
  end;

  (* // Print
  for j:=0 to cantFilas -1 do
  begin
	for i := 0 to cantColumnas -1 do
	begin
		write(' ', struct[(j*cantColumnas) + i]);
    end;
    writeln(' ');
    writeln(' ');
  end;
  *)
  Result := tabloide;
end;

procedure TMIPSimplex.DumpSistemaToPlainTableForGPUs(filename: string);
var
  i, j, cantFilas, cantColumnas: integer;
  tabloide: TSimplexGPUs;
  f: textfile;
begin

  Assign(f, filename);
  rewrite(f);

  tabloide := self.toStruct;
  cantColumnas := Trunc(tabloide[2]);
  cantFilas := Trunc(tabloide[cantColumnas + 1]) + 6;
  for j := 0 to (cantFilas - 1) do
  begin
    for i := 0 to (cantColumnas - 1) do
    begin
         write(f, tabloide[(j*cantColumnas) + i]);
         write(f, ', ');
    end;
    writeln(f);
  end;
  writeln(f);

  closefile(f);
end;