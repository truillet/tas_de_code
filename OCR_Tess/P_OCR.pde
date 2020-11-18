import java.io.File;
import net.sourceforge.tess4j.*; // Tess4J - OCR recognition

class P_OCR {
  private String filename;
  private String result;
  
  
  P_OCR() {
    this.filename="";
    this.result="";
  };
  
  P_OCR(String filename) {
    super();
    this.filename = filename;
  }
  
  void setFilename(String filename){
    this.filename=filename;
  }
  
  String recognize(){
    File imageFile = new File(dataPath("/doc")+ "/" + this.filename);
    // println(dataPath("/doc")+ "/" + this.filename);
    
    ITesseract instance = new Tesseract1(); // JNA Direct Mapping
    instance.setDatapath(dataPath("") +"/tessdata"); // path to tessdata directory 
    try {
      this.result = instance.doOCR(imageFile);
      return(result);
    }
    catch (TesseractException e) {
      return("ERROR");
    }    
  }
}
