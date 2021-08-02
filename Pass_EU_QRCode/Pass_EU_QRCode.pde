/******************************* 
 * Pass EU QR Code recogniser
 * detects Digital Certificate QRCodes and displays results
 *
 * (c) Ph. Truillet, July 2021
 * updated on 29/07/2021
 *
 */
 
 
import processing.video.*;
import com.google.zxing.*;
import java.awt.image.BufferedImage;
import java.util.zip.Inflater;
import COSE.Message;
import com.google.iot.cbor.CborMap;

FSM mae;
Capture cam;
Reader reader = new MultiFormatReader(); // ZXing
EU_Pass pass;

String certificate="";
PVector v0,v1,v2,v3;
float distance; 


void setup() {
 size(640, 550);
 PFont myFont;
 myFont = loadFont("Myriad.vlw");
 textFont(myFont, 14);
 
 // démarrer la webcam
 cam = new Capture(this, 640, 480);
 cam.start(); // démarrer la caméra
 
 mae = FSM.INITIAL;
}


void draw() {
  background(0);
  switch (mae) {
    case INITIAL:
       image(cam, 0, 0);
       try {
         LuminanceSource source = new BufferedImageLuminanceSource((BufferedImage)cam.getImage());
         BinaryBitmap bitmap = new BinaryBitmap(new HybridBinarizer(source));    
         Result result = reader.decode(bitmap); 
         if (result.getText() != null) { 
           fill(#000000);
           rect(0,480,640,70);
           fill(#ffffff);
       
           // is it a valid QR-Code? 
           String[] m = match(result.getText(),"HC1");
           if (m != null) {
             certificate = result.getText();
             mae=FSM.DECODE;
           }
           else
             certificate ="";
           ResultPoint[] points = result.getResultPoints();
 
           // Draw some ellipses on at the control points
           v0 = new PVector(points[0].getX(), points[0].getY());
           v1 = new PVector(points[1].getX(), points[1].getY());
           v2 = new PVector(points[2].getX(), points[2].getY());
           v3 = new PVector(points[2].getX(), points[0].getY());
           distance = v0.dist(v1)+40;
           noStroke();     
           fill(255,255,255,100);
           quad(points[0].getX(),points[0].getY(),points[1].getX(),points[1].getY(),points[2].getX(),points[2].getY(),points[3].getX(),points[3].getY());            
          }
       } 
       catch (Exception e) {
       // println(e.toString()); 
       }   
      break;
    
    case DECODE:
      // result is a COSE object  
      // 1 - suppress prefix "HC1:"
      certificate = certificate.replace("HC1:",""); //  retirer le préfixe HC1:
      try {
        // inflate string
        byte[] zlibdata = Base45.getDecoder().decode(certificate); // décode le base45      
        Inflater inflater = new Inflater(); // décompresser avec zlib
        inflater.setInput(zlibdata);
        byte[] cbor = new byte[500];
        int resultLength = inflater.inflate(cbor);
        byte[] cbor2 = Arrays.copyOf(cbor, resultLength);    
        inflater.end();
                 
        Message m = Message.DecodeFromBytes(cbor2);     
        CborMap cm = CborMap.createFromCborByteArray(m.GetContent()); 
        certificate = cm.toString(2); // la version JSON est dans le second champ 

        mae=FSM.DECODED;  
      }
      catch (CoseException ce) {
        println("Erreur Cose");
      }
      catch (Exception e) {
        println("Erreur");
      }
      break;
      
    case DECODED:
      // extract datas and displays result
      fill(255); // white color
      pass = new EU_Pass(certificate);
      text("Emetteur : "+ pass.getEmitter(), 50,100); 
      text("Identité : " + pass.getIdentity(),50,150);
      text("Date de Naissance : "+ pass.getBirthdate(), 280,150); 
      text("Etat vaccinal : " + pass.isVaccinated(), 50,200);
      text("Nombre de dose(s) : " + pass.getNbDoses(),280,200);
      
      break;
      
    default:
      break;
  }   
}

void captureEvent(Capture c) {
  cam.read();  
}

void keyPressed(){
  switch (mae) {
    case DECODED:
      mae = FSM.INITIAL;
      break;
      
    default:
      break;
  }
}
