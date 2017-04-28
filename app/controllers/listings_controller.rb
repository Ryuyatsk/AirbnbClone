class ListingsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_listing, only: [:show, :update, :basics, :description, :address, :price, :photos, :calendar, :bankaccount, :publish]
  before_action :access_deny, only: [:basics, :description, :address, :price, :photos, :calendar, :bankaccount, :publish]

  def index
    @listings = current_user.listings
  end

  def show
    @photos = @listing.photos

    # 今のユーザーがこのリスティングを予約しているか否か
    @curretUserBooking = Reservation.where("listing_id = ? AND user_id = ?",@listing.id,current_user.id).present? if current_user

    @reviews = @listing.reviews

    @curretUserBooking = @reviews.find_by(user_id: current_user.id) if current_user

  end

  def new
    # 現在のユーザーのリスティングの作成
    @listing = current_user.listings.build
  end

  def create
    # パラメーターとともに現在のリスティングを作成
    @listing = current_user.listings.build(listing_params)

    if @listing.save
      redirect_to manage_listing_basics_path(@listing), nitice: "リスティングを作成・保存しました"
    else
      redirect_to new_listing_path, nitice: "リスティングを作成・保存できませんでした"
    end

  end

  def edit
  end

  def update
    if @listing.update(listing_params)
      redirect_to :back, notice: "更新できました"
    end
  end

  def basics
  end

  def description
  end

  def address
  end

  def price
  end

  def photos
    @photo = Photo.new
  end

  def calendar
  end

  def bankaccount
    @user = @listing.user
    session[:listing_id] = @listing.id
  end

  def publish
  end

  def not_checked
    @listing = Listing.find(params[:listing_id])
    @listing.update(not_checked: params[:not_checked])
    render :nothing => true
  end

  private
  def listing_params
    params.require(:listing).permit(:home_type, :pet_type, :breeding_years, :pet_size, :price_pernight, :address, :listing_title, :listing_content, :active)
  end

  def set_listing
    @listing = Listing.find(params[:id])
  end

  def access_deny
    if !(current_user == @listing.user)
      redirect_to root_path, notice: "他人の編集ページにはアクセスできません"
    end
  end


end
