class PotD { // Pic of the Day

  private String appID="RLP0aqvcMGoGJRIZWRhtIoQrcNRLMkAqX9O8OwjV"; // to be replaced with your appid 
  private String copyright; // seems optional
  // date
  private String title;
  private String explanation;
  private String type; // media type
  private String img_url;

  PotD(){
    this.copyright="";
    this.title="";
    this.explanation="";
    this.type="";
    this.img_url=null;
    
    this.update();
  }
 
  String getTitle(){
    return(this.title);
  }
 
   String getUrl(){
    return(this.img_url);
  }
   
   String getExplanation(){
    return(this.explanation);
  }
  
  void update(){
    JSONObject json;    
    try {
      String requete = "https://api.nasa.gov/planetary/apod?api_key="+appID;
      json = loadJSONObject(requete);
            
      this.title=json.getString("title");
      this.type=json.getString("media_type");
      this.img_url=json.getString("url");
      this.explanation=json.getString("explanation");
    }
    catch (Exception e) {};
  }
}
