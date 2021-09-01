package com.bjpn.crm.exception;

/**
 * 登录异常类
 * 登录时发生的异常都会向上抛出具体信息为message的LoginException
 */
public class LoginException extends Exception{
    public LoginException(String message) {
        super(message);
    }
}
