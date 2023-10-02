public class ReturnedGreeting{

    private String content;

    public ReturnedGreeting (){

    }

    public ReturnedGreeting(String content){
        this.content = content;
    }
    public String getContent(){
        return this.content;
    }

    public void setContent(String content){
        this.content  = content;
    }
}