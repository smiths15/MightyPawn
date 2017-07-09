class PiecesController < ApplicationController

  def show
    @piece = Piece.find(params[:id])
    @game = Game.find(@piece.game_id)
  end

  def update  
    @piece = Piece.find(params[:id])
    @game = Game.find(@piece.game_id)

    if @piece.valid_move?(params[:y_coord].to_i, params[:x_coord].to_i)
      begin
        #will take piece off the board if captured, if not captured, this will do nothing
        @piece.move_to!(params[:y_coord].to_i, params[:x_coord].to_i)
      rescue Exception => e
        return redirect_to piece_path(@piece), alert: e.message
      end
      #update the current pieces position
      @piece.update_attributes(position_row: params[:y_coord], position_column: params[:x_coord], moves: @piece.moves + 1)
      redirect_to game_path(@game)
    else
      redirect_to piece_path(@piece), alert: "Invalid move for piece. Please try again."
    end
  
  end

end
