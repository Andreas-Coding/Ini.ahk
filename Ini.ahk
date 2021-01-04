/**
    * Class: Ini
    *   A static class based utility wrapper for the ini commands of ahk
    *   Set up do work directly with ahk objects
    *   @Version 1.0 Release
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
            r[SubStr(p, 1, pos - 1)] := SubStr(p, pos + 1)
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


    /**
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


    /**
        * Method: writeSection(iniFile, section, object)
        *   sets/updates given section with the objects key/value pairs
        * Params:
        *   iniFile - the path to the ini
        *   section - the section within the ini
        *   object  - the array to written to the iniFile
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


    /**
        * Method: write2dimArray(iniFile, object)
        *   writes a two dimensional array to the iniFile
        *   allows an easy dump
        * Params:
        *   iniFile - the path to the ini
        *   object  - the two dimensional array to written to the iniFile
        * Return:
        *   nothing
    */
    write2dimArray(iniFile, object){
        for sec, element in object
            this.writeSection(iniFile, sec, element)
    }


    Class Instance {

        /**
            * Method: __New(iniFile)
            *   creates a new instance of the Ini.Instance class with given iniFile attached
            * Params:
            *   iniFile - the path to the ini
            * Return:
            *   the new IniInstance class instance
        */
        __New(iniFile){
            this.iniFile := iniFile
        }
        
        /**
            * Method: readKey(section, key)
            *   reads the given key from the given section of the instaces iniFile
            * Params:
            *   section - the section within the ini
            *   key     - the key within the section
            * Return:
            *   the value retrieved from the ini
        */
        readKey(section, key){
            return, Ini.readKey(this.iniFile, section, key)
        }

        /**
            * Method: readSection(section)
            *   reads the content of a section into an associative array
            * Params:
            *   section - the section within the ini
            * Return:
            *   the associative array of the given section
        */
        readSection(section){
            return, Ini.readSection(this.iniFile, section)
        }

        /**
            * Method: readSectionList()
            *   retrieves an array of contained section names
            * Params:
            * Return:
            *   the array of all section names
        */
        readSectionList(){
            return, Ini.readSectionList(this.iniFile)
        }

        /**
            * Method: readAll()
            *   retrieves a two dimensional associative array of the instances entire iniFile
            * Params:
            * Return:
            *   the two dimensional associative array of the inis content
        */
        readAll(){
            return, Ini.readAll(this.iniFile)
        }

        /**
            * Method: writeKey(section, key, value)
            *   sets/updates given key in given section of the instances inifile with given value
            * Params:
            *   section - the section within the ini
            *   key     - the key within the section
            *   value   - the value to be set
            * Return:
            *   nothing
        */
        writeKey(section, key, value){
            return, Ini.writeKey(this.iniFile, section, key, value)
        }
        
        /**
            * Method: writeKey(section, object)
            *   sets/updates given section with the objects key/value pairs
            * Params:
            *   section - the section within the ini
            *   object  - the associative array to written to the iniFile
            * Return:
            *   nothing
        */
        writeSection(section, object){
            return, Ini.writeSection(this.iniFile, section, object)
        }

        /**
            * Method: write2dimArray(object)
            *   writes a two dimensional array to the iniFile
            *   allows an easy dump
            * Params:
            *   object  - the two dimensional array to written to the iniFile
            * Return:
            *   nothing
        */
        write2dimArray(object){
            return, Ini.write2dimArray(this.iniFile, object)
        }

    }


    /**
        * Method: __New()
        *   blocks the creation of instances of the Ini class.
        **  To create instances bound to a specific iniFile, use new Ini.Instance(iniFile)
        * Params:
        * Return:
        *   False
    */
    __New(){
        return, ""
    }


}