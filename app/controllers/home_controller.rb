require 'devise'
#require 'mailgun'

class HomeController < ApplicationController
    
    def index
      @posts = Post.all.reverse
    end
    
    def write
        unless user_signed_in?
            redirect_to "/users/sign_in"
        end
            
        ema = current_user.email
        matchid = Match.find_by starter: current_user.email,receiver: "receiver"
        if matchid == nil
            o =  [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten
            uid  =  Time.new.asctime + (0...50).map{ o[rand(o.length)]  }.join
            
            match = Match.new
            match.key = uid; 
        end
        
        match.starter = current_user.email 
        match.receiver = params[:receiver]
        
        post = Post.new
        post.content = params[:content]
        post.shared = params[:shared]
        post.sent = params[:sent]
        
        match.save
        
        post.user_id = current_user.id
        post.match_id = match.id 
        
        post.save
        
            
    #mg_client = Mailgun::Client.new("key-b748cb86971bfc3e46ff02fe897bbd26")

    # message_params =  {
    #           from: 'insultinstead123@gmail.com',
    #           to: params[:receiver] ,
    #           subject:'*주의* 누군가가 당신을 욕했습니다!!!!!' ,
    #           text: params[:content]}

    # result = mg_client.send_message('sandboxd5c47e25bd5b46ca920848d4c202601f.mailgun.org', message_params).to_h!

    #   message_id = result['id']
    #   message = result['message']
    
            
        redirect_to "/"
    end 
    
    def revenge
    end    
    
    def writepage
        unless user_signed_in?
            redirect_to "/users/sign_in"
        end
    end
    
    def vslist
        
        unless user_signed_in?
            redirect_to "/users/sign_in"
        end
        @matchstart =  Match.where( 'starter = ? ',current_user.email).reverse
        @matchreceiver = Match.where( 'receiver = ?', current_user.email).reverse
    end
    
    def vsstart
        
        unless user_signed_in?
            redirect_to "/users/sign_in"
        end
        @one_match = Match.find(params[:match_id])
    end
    
    
    def ztesting
        
        unless user_signed_in?
            redirect_to "/users/sign_in"
        end
        # mt = Match.new
        # mt.key = ""
        # mt.starter = current_user.email
        # mt.receiver = "test@gmail.com"
        # mt.save
    end
    
    def logged_in?
    !current_user.nil?
    end
    
end
