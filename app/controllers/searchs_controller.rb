class SearchsController < ApplicationController
  def search
    #viewのform_tagにて
    #選択したmodelの値を@modelに代入。
    @model = params["model"]
    #選択した検索方法の値を@methodに代入。
    @method = params["method"]
    #検索ワードを@contentを代入。
    @content =params["content"]
    #@model, @content, @methodを代入した。
    #search_forを@recordsに代入。
    @records = search_for(@model, @content, @method)
  end

  private
  def search_for(model, content, method)
    #選択したモデルがuserだったら
    if model == 'user'
      #選択した検索方法が完全一致だったら
      if method =='perfect'
        User.where(name: content)
      #選択した検索方法が部分一致だったら
      else
        User.where('name LIKE ?', '%'+content+'%') #LIKEは曖昧な際に使える
      end
    #選択したモデルがBookだったら
    elsif model == 'book'
      if method == 'perfect'
        Book.where(title: content)
      else
        Book.where('title LIKE ?', '%'+content+"%")
      end
    end
  end

end
