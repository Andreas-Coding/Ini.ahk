#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

initestfile := "test1.ini"
test2 := new Ini.Instance("test2.ini")
Ini.writeKey(initestfile, "writekey", "test01", "value I guess")
Ini.writeSection(initestfile, "standard array", ["test1", "test2", "test3"])
Ini.writeSection(initestfile, "associative array", {"key1": "val1", "key2": "val2", "key3": "val3"})
MsgBox, % arrToStr(Ini.readAll(initestfile))

test2.write2dimArray(Ini.readAll(initestfile)) ;copys the test1.ini content and writes it to test2.ini
test2.writeKey("test2 only", "a key", "a value")
MsgBox, % arrToStr(test2.readAll())

return


arrToStr(arr){
    if(!IsObject(arr))
        return, arr
    
    r := "{"
    for k, v in arr
        r .= Format("{1:s} ""{2:}"": ""{3:}"""
                , ((A_Index > 1) ? "," : "")
                , k, arrToStr(v))
    return, r . "}"
}



#Include, A_ScriptDir\..\..\Ini.ahk