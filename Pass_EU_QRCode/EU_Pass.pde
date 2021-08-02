import java.util.Date;
import java.util.Hashtable; 
import java.util.Map; 

class EU_Pass {
  private String result;
  
  private String name;
  private String surname;
  private String birthdate;
  private String emitter;
  private Date startDate;
  private Date expiryDate;
  private boolean vaccinated;
  private int nbDoses;

  private Map<String, String> vmp; // Vaccine Medicinal Product
  private Map<String, String> vm; // Vaccine Manufacturer
 
  EU_Pass(String result) {
    this.result= result;
    
    this.name = "";
    this.surname = "";
    this.birthdate = "";
    this.vaccinated = false;
    this.nbDoses = 0;
    
    // créer la map (de https://ec.europa.eu/health/sites/default/files/ehealth/docs/digital-green-certificates_dt-specifications_en.pdf)
    this.vmp = new Hashtable<String, String>(); // Vaccine authorized in the EU
    vmp.put("EU/1/20/1528","Comirnaty");
    vmp.put("EU/1/20/1507","COVID-19 Vaccine Moderna");
    vmp.put("EU/1/21/1529","Vaxzevria");
    vmp.put("EU/1/20/1525","COVID-19 Vaccine Janssen");
    
    this.vm = new Hashtable<String, String>(); // Vaccine Manufacturer
    vm.put("ORG-100001699", "AstraZeneca AB");
    vm.put("ORG-100030215", "Biontech Manufacturing GmbH");
    vm.put("ORG-100001417", "Janssen-Cilag International");
    vm.put("ORG-100031184", "Moderna Biotech Spain S.L.");
    // to be completed
    this.update();
  }
  
  void update() {
    try {
      processing.data.JSONObject json = parseJSONObject(this.result);  
      this.emitter = json.getString("1"); // Emetteur du certificat 
      
      processing.data.JSONObject obj1 = json.getJSONObject("-260");
      processing.data.JSONObject obj2 = obj1.getJSONObject("1");
      this.birthdate = obj2.getString("dob");
           
      processing.data.JSONObject obj4 = obj2.getJSONObject("nam");
      this.name = obj4.getString("fn");
      this.surname = obj4.getString("gn");
      
      processing.data.JSONArray array1 = obj2.getJSONArray("v"); // données de vaccination
      this.vaccinated = true;
      processing.data.JSONObject obj3 = array1.getJSONObject(0);     
      // println("\t\t== " + obj3.getString("ma") + " =="); // vaccine manufacturer
      // println("\t\t== " + obj3.getString("mp") + " =="); // Vaccine product
      this.nbDoses = obj3.getInt("dn");

     
      this.startDate = new Date(json.getLong("6")); // Date de création du certificat (à revoir)
      this.expiryDate = new Date(json.getLong("4")); // Date de fin du certificat
    }
    catch(NumberFormatException e) {
      println("Erreur de transcription de format");
    } // problème conversion de dates
    catch(JSONException je) {// todo if not vaccinated
      println("Erreur JSON");
    }
    catch (Exception e) {}
  }
  
  String getEmitter() {
    return (this.emitter);
  }
  String getBirthdate() {
    return(this.birthdate);
  }
  
  String getName(){
    return(this.name);
  }
  String getSurname(){
    return(this.surname);
  }
  String getIdentity(){
    return(this.surname + " " + this.name);
  }
  
  boolean isVaccinated() {
    return(this.vaccinated);
  }
    
  int getNbDoses() {
    return(this.nbDoses);
  }
}
