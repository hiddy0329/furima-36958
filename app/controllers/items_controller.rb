class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :check_item_and_user, only: [:edit, :destroy]

  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item_form = ItemForm.new
  end

  def create
    @item_form = ItemForm.new(item_form_params)
    if @item_form.valid?
      @item_form.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comments = @item.comments.includes(:user)
    @comment = Comment.new
  end

  def edit
    # attributesメソッドで属性値をハッシュ形式で取得する
    item_attributes = @item.attributes
    # item_attributesを引数で受け取りインスタンスを生成
    @item_form = ItemForm.new(item_attributes)
    # itemに紐づくtagを取得
    @item_form.tag_name = @item.tags&.first&.tag_name
  end

  def update
    # ユーザーが編集後の内容をバリデーションにかけるため、新たにインスタンスを生成する
    @item_form = ItemForm.new(item_form_params)

    # 画像を選択し直さない場合は、自己代入演算子で@itemに紐づく画像をそのまま代入
    @item_form.images ||= @item.images.blobs

    if @item_form.valid? 
      @item_form.update(item_form_params, @item)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  def inclimental_search
    # 新規出品、編集時のインクリメンタル検索用の処理
    return nil if params[:keyword] == ""
    tag = Tag.where(['tag_name LIKE ?', "%#{params[:keyword]}%"] )
    render json:{ keyword: tag }
    # /新規出品、編集時のインクリメンタル検索用の処理
  end

  def search
    # params[:q]がnilではない且つ、params[:q][:name]がnilではないとき（商品名の欄が入力されているとき）
    # if params[:q] && params[:q][:name]と同じような意味合い
    if params[:q]&.dig(:name)
      # squishメソッドで余分なスペースを削除する
      squished_keywords = params[:q][:name].squish
      ## 半角スペースを区切り文字として配列を生成し、paramsに入れる
      params[:q][:name_cont_any] = squished_keywords.split(" ")
    end
    # ransakを用いた検索処理
    # 検索オブジェクトを作成し、ransakを利用したフォームから送られたデータを受け取る
    @q = Item.ransack(params[:q])
    # resultメソッドで検索結果を受け取る
    @items = @q.result
  end

  private

  def item_form_params
    params.require(:item_form).permit(:name, :description, :category_id, :state_id, :postage_id, :region_id, :shipping_date_id,
                  :price, :tag_name, {images: []}).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def check_item_and_user
    if current_user.id != @item.user_id || @item.order.present?
      redirect_to root_path
    end
  end
  
end
