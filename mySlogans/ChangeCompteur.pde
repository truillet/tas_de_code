
import java.util.Timer;
import java.util.TimerTask;

class ChangeCompteur
{
  Timer timer;
  private long value;
  
  public ChangeCompteur(long initialValue, int seconds) {
    value = initialValue;
    timer = new Timer();
    timer.scheduleAtFixedRate(new ReminderTask(), seconds * 1000, seconds * 1000);
  }
  
  public long getValue() {
    return(value);
  }
  
  public void setValue(long v) {
    value =v;
  }
  
  class ReminderTask extends TimerTask {
    public void run() {
      value++;
    }
  }
}