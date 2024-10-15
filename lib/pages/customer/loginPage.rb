require_relative '../../../features/page_bases/page_base.rb'

class LoginPage < PageBase

    #elements block begin
                                           
    element :buttonLogin,           :xpath, '//span[@class="flex items-center transition-all duration-200 rounded-md text-xs px-2 py-1" and contains(text(), "Log In")]'
    element :buttonDoLogin,         :xpath, '//button[@class="bg-primary rounded-[10px] py-1 text-textContrast"]//div[contains(text(), "Log In")]'
    element :fieldAboutUser,        :xpath, '//div[@class="flex top-0 relative gap-12 flex-col lg:flex-row lg:gap-16 lg:pt-10 lg:px-10 w-full"]'
    element :fieldWrongCredentials, :xpath, '//*[contains(text(), "incorrect")]'    
    element :fieldUserEmail,                '#email_desktop'
    element :fieldUserPassword,             '#password_desktop'

    #elements block end

    #variables block begin

        @emailLogin    = ''
        @passwordLogin = ''

    #variables block end

    #methods block begin
    
    private

    def actionSetEmail
        if AMBIENTE.eql?('prod')
            @emailLogin = EMAILPROD
        elsif AMBIENTE.eql?('staging')
            @emailLogin = EMAILSTAGING
        end
    end

    def actionSetPassword(credentialStatus)
        if credentialStatus.eql?('true')
            if AMBIENTE.eql?('prod')
                @passwordLogin = PASSWORDPROD
            elsif AMBIENTE.eql?('staging')
                @passwordLogin = PASSWORDSTAGING
            end
        else
            @passwordLogin = '123$WrongValue'
        end
    end
    
    public

    def clickButtonLogin
        clickIfVisible :buttonLogin
    end

    def sendEmail
        actionSetEmail
        send_keys :fieldUserEmail, @emailLogin
    end

    def sendPassword(credentialStatus)
        actionSetPassword(credentialStatus)            

        send_keys :fieldUserPassword, @passwordLogin
    end

    def clickButtonDoLogin
        clickIfVisible :buttonDoLogin
    end 

    def userLogged?
        sleep 10
        return visible_element? :fieldAboutUser
    end

    def notUserLogged?
        sleep 10
        return visible_element? :fieldWrongCredentials
    end

    #methods block end
end