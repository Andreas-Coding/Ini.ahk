/**
    * Class: Ini
    *   A static class based utility wrapper for the ini commands of ahk
    *   Set up do work directly with ahk objects
*/
class Ini {


    /**
        * Method: readKey(iniFile, section, key)
        *   reads the given key from the given section of the given iniFile
        * Params:
        *   iniFile - the path to the ini
        *   section - the section within the ini
        *   key     - the key within the section
        * Return:
        *   the value retrieved from the ini
    */
    readKey(iniFile, section, key){
        IniRead, r, % iniFile, % section, % key, % {}
        return, r
    }


    /**
        * Method: readSection(iniFile, section)
        *   reads the content of a section into an associative array
        * Params:
        *   iniFile - the path to the ini
        *   section - the section within the ini
        * Return:
        *   the associative array of the given section
    */
    readSection(iniFile, section){
        IniRead, s, % iniFile, % section
        r := {}
        for _, p in StrSplit(s, "`n") {
            pos := InStr(p, "=")
            r[SubStr(p, , pos - 1)] := SubStr(p, pos + 1)
        }
        return, r
    }


    /**
        * Method: readSectionList(iniFile)
        *   retrieves an array of contained section names
        * Params:
        *   iniFile - the path to the ini
        * Return:
        *   the array of all section names
    */
    readSectionList(iniFile){
        IniRead, s, % iniFile
        return, StrSplit(s, "`n")
    }


    /**
        * Method: readAll(iniFile)
        *   retrieves a two dimensional associative array of the entire iniFile
        * Params:
        *   iniFile - the path to the ini
        * Return:
        *   the two dimensional associative array of the inis content
    */
    readAll(iniFile){
        r := {}
        for _, s in this.readSectionList(iniFile)
            r[s] := this.readSection(iniFile, s)
        return, r
    }


    /*
        * Method: writeKey(iniFile, section, key, value)
        *   sets/updates given key in given section of given file with given value
        * Params:
        *   iniFile - the path to the ini
        *   section - the section within the ini
        *   key     - the key within the section
        *   value   - the value to be set
        * Return:
        *   nothing
    */
    writeKey(iniFile, section, key, value){
        IniWrite, % value, % iniFile, % section, % key
    }


    /*
        * Method: writeKey(iniFile, section, key, value)
        *   sets/updates given key in given section of given file with given value
        * Params:
        *   iniFile - the path to the ini
        *   section - the section within the ini
        *   object  - the associative array to written to the iniFile
        * Return:
        *   nothing
    */
    writeSection(iniFile, section, object){
        for k, e in object {
            if(A_Index > 1)
                pairs .= "`n"
            pairs .= k . "=" . e
        }
        IniWrite, % pairs, % iniFile, % section
    }


}