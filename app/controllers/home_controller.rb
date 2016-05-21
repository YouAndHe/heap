require 'devise'
class HomeController < ApplicationController
    skip_before_action :require_login, only: [:index]
    
    def index
      @posts = Post.all.reverse
    end
    
    def write
        
            matchid = Match.where( "starter=?,receiver=?",params[:starter],params[:receiver])
            unless matchid == nil
                post = Post.new
                post.content = params[:content]
                post.shared = params[:shared];
                post.sent = params[:sent]
                
                o =  [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten.join
                uid  =  Time.now + (0...50).map{ o[rand(o.length)]  }.join
                
                match = match.new
                match.key = uid; 
                match.starter = params[:userid]
                match.receiver = params[:receiver]
                
                user = User.find_by email: params[:starter]
                if user == nil
                    puts "user not foud"
                end
                
                post.user_id = user
                post.match_id = match.id 
                
                post.save
                match.save
                
            end
            redirect_to "/index"
    end 
    
    def writepage
    
    end
    
    def vslist
        @matchstart =  Match.where( 'starter = ? ',current_user.email).reverse
        @matchreceiver = Match.where( 'receiver = ?', current_user.email).reverse
    end
    
    def vsstart
        @one_match = Match.find(params[:match_id])
    end
    
    
    def ztesting
        # mt = Match.new
        # mt.key = ""
        # mt.starter = current_user.email
        # mt.receiver = "test@gmail.com"
        # mt.save
        pt = Post.new
        pt.content = "테스트스트링1t@t"
        pt.shared = true
        pt.sent = true
        pt.match_id = 1;
        pt.user_id = 1;
        pt.save
        
        pt2 = Post.new
        pt2.content = "테스트스트링2test@gmail.com"
        pt2.shared = true
        pt2.sent = true
        pt2.match_id = 1;
        pt2.user_id = 2;
        pt2.save
    end
    
end
