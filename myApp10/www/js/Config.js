//----------------------------------------------------------------------------------------
//                                      local - false if app mode
//                                              true if web mode
//----------------------------------------------------------------------------------------


var local = false;

var ASMXURL = 'http://localhost:31629/WebService.asmx/';
if (!local) {
    ASMXURL = 'http://proj.ruppin.ac.il/bgroup57/test1/tar1/WebService.asmx/';
}