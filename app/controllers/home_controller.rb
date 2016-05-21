require 'devise'
require 'mailgun'

class HomeController < ApplicationController
    
    def index
    #   @posts = Post.all.reverse
      @posts = Post.where('shared = ?',true).reverse
    end
    
    def write
        unless user_signed_in?
            redirect_to "/users/sign_in"
        end
            
        ema = current_user.email
        matchid = Match.find_by starter: current_user.email,receiver: "receiver"
        if matchid == nil
            o =  [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten
            uid  =  Time.new.to_f.to_s + (0...50).map{ o[rand(o.length)]  }.join
            
            match = Match.new
            match.key = uid; 
        end
        
        match.starter = current_user.email 
        match.receiver = params[:receiver]
        
        post = Post.new
        post.content = params[:content]
        post.shared = params[:shared]
        post.sent = params[:sent]
        
        # 욕설 알고리즘 시작
        yok = ["띠붕",
        "개자식",
        "돌아이",
        "개놈",
        "뀩",
        "뿌우우웅",
        "히히",
        "멍청이",
        "말미잘",
        "싸이코",
        "뽀큐",
        "바보",]
        
        arrayzim = post.content.split(' ')
        arraynumber = arrayzim.length
        
        if arraynumber == 0 
        
        end
        randomindex = (1..arraynumber).select(&:odd?).sample(arraynumber-2).sort  
        
        for i in 0..randomindex.length-1
          arrayzim.insert(randomindex.sample, yok.sample)
        end
      
        words = String.new
        
        arrayzim.each do |word|
          words += (word+ " ")
        end
        post.content = words
        # 욕설 알고리즘 끝
        match.save
        
        post.user_id = current_user.id
        post.match_id = match.id 
        
        post.save
            
        mg_client = Mailgun::Client.new("key-b748cb86971bfc3e46ff02fe897bbd26")
    
        message_params =  {
                  from: 'insultinstead123@gmail.com',
                  to: match.receiver,
                  subject:'*주의* 누군가가 당신을 욕했습니다!!!!!' ,
                  text: post.content + "\n 복수하러가기  : http://heap-insult-unamed12.c9users.io/home/revengepage/" + match.key.to_s
        }
    
        result = mg_client.send_message('sandboxd5c47e25bd5b46ca920848d4c202601f.mailgun.org', message_params).to_h!
    
          message_id = result['id']
          message = result['message']
          
        redirect_to "/"
    end 
    
     def revenge
        unless user_signed_in?
            redirect_to "/users/sign_in"
        end
        
        key=params[:matchkey]
        matchkey=Match.find_by key: key
        starter=matchkey.starter
        receiver=matchkey.receiver
            
        #ema = current_user.email
        #matchid = Match.find_by starter: current_user.email,receiver: "receiver"
        verify = Match.find_by key: matchkey
        ############
        ############
        
        post = Post.new
        post.content = params[:content]
        
        post.shared = true
        post.sent = true
        
        
        # 욕설 알고리즘 시작
        yok = ["띠붕",
        "개자식",
        "돌아이",
        "개놈",
        "히히",
        "멍청이",
        "말미잘",
        "싸이코",
        "바보",]
        
        arrayzim = post.content.split(' ')
        arraynumber = arrayzim.length
        
        if arraynumber == 0 
        
        end
        randomindex = (1..arraynumber).select(&:odd?).sample(arraynumber-2).sort  
        
        for i in 0..randomindex.length-1
          arrayzim.insert(randomindex.sample, yok.sample)
        end
      
        words = String.new
        
        arrayzim.each do |word|
          words += (word+ " ")
        end
        post.content=words
        
        
        # 욕설 알고리즘 끝
        
        mg_client = Mailgun::Client.new("key-b748cb86971bfc3e46ff02fe897bbd26")
    
        message_params =  {
                  from: 'insultinstead123@gmail.com',
                  to: receiver,
                  subject:'*주의* 누군가가 당신을 욕했습니다!!!!!' ,
                  text: words + "\n 복수하러가기  : http://heap-insult-unamed12.c9users.io/home/revengepage/" + match.key.to_s
        }
    
        result = mg_client.send_message('sandboxd5c47e25bd5b46ca920848d4c202601f.mailgun.org', message_params).to_h!
    
          message_id = result['id']
          message = result['message']
          
        post.id=1
        post.match_id=matchkey.id
        post.save
        
        redirect_to "/"
    end 
    
    def revengepage
        @mat = params[:matchkey]
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

end
