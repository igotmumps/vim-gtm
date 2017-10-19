PROFILETBX
	Q
GETFROMPROFILE
	K  D SYSVAR^SCADRV0() S (ER,TLO,%LOGID)="",%UID=8888,%UCLS="SCA",TLO=$$TLO^UTLO()
	set data=$ZCMD
	new ObjType,ObjId
	set ObjType=$p(data,",",1)
	set ObjId=$p(data,",",2)
	if $G(ObjType)="" Q
	if $G(ObjId)="" Q
	;
	new a,ext,file,ret,tok,x
	;
	if ObjType="Routine" set ext=".m",dir="routine",ObjType="Mumps"
	if ObjType="Procedure" set ext=".PROC",dir="procedure"
	if ObjType="Batch" set ext=".BATCH",dir="batch"
	;
	set x=$$INITOBJ^MRPC121(.ret,1,ObjType,ObjId)
	set x=$$LV2V^MSG(ret,.a)
	set x=$P(a(1),$c(13,10),1)
	if +x'=1 w "Fail",! quit 
	set tok=$P(a(1),$c(13,10),2)
	if tok
	kill a
loop	set x=$$RETOBJ^MRPC121(.ret,1,tok)
	set x=$$LV2V^MSG(ret,.a)
	if +a($o(a(""),-1))'=0 goto loop
	set file="/althome/ntp416/wb/prftst13/"_$$FUNC^%LCASE(dir)_"/"_ObjId_ext
	close file
	open file
	n i
	set i="" for  set i=$o(a(i)) quit:i=""  do
	.  set line=$TR(a(i),$C(13),"")
	.  use file w line
	close file
	w "ok",!
	quit
	;
SAVETOPROFILE
	K  D SYSVAR^SCADRV0() S (ER,TLO,%LOGID)="",%UID=8888,%UCLS="SCA",TLO=$$TLO^UTLO()
	new code,data,et,x,line,i,tok,locfile
	set data=$ZCMD
	new objType,objId
	set objType=$p(data,",",1)
	set objId=$p(data,",",2)
	set file=$p(data,",",3)
	if $G(objType)="" Q
	if $G(objId)="" Q
	set x=$$FILE^%ZOPEN(file,"READ",5)
	if +x=0 write x quit
	;
	set tok=""
	set locfile=objId_"."_objType
	for  set line=$$^%ZREAD(file,.et) quit:+et'=0  do
	.  set code=""
	.  for i=1:1:$l(line) do 
	..  set char=$a($e(line,i))
	..  set code=code_"|"_char
	.  set code=code_"|"_13_"|"_10
	.  set x=$$INITCODE^MRPC121(.ret,1,code,tok)
	.  kill a
	.  set x=$$LV2V^MSG(ret,.a)
	.  set tok=$g(a(1))
	close file
	set x=$$CHECKOBJ^MRPC121(.ret,1,objId_"."_objType,tok)
	set x=$$SAVEOBJ^MRPC121(.ret,1,locfile,tok,"NTP416")
	quit
