package com.sap.cap.productsservice.TestingStomp;

public class HelloMessage{

    private String message;

    public HelloMessage(){

    }

    public HelloMessage(String message){
        this.message= message;

    }

    public String getMessage(){
        return this.message;

    }

    public void setMessage(String message){
        this.message= message;
    }


}