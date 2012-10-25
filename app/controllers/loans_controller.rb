class LoansController < ApplicationController
  
  def cancel
  end

  # POST /loans/issue/:id
  def issue
    loan = Loan.held.find(params[:id]).joins(:games).where(owner: logged_in_user) rescue nil

    respond_to do |format|

      if loan.nil?
        format.html { redirect_to root_path }
      elsif loan != loan.game.loans.active.first
        flash[:notice] = 'There are earlier holds on this game, process them first'
        format.html { redirect_to account_user_path(logged_in_user) }
      else
        loan.status = Loan::STATUS_ONLOAN
        if loan.save
          flash[:success] = "The hold on #{loan.game.title} for #{loan.user.name} has been flagged as issued"
          format.html { redirect_to account_user_path(logged_in_user) }
        else
          flash[:error] = "Could not update loan status for #{loan.game}"
          format.html{ redirect_to account_user_path(logged_in_user) }
              end
      end
    end
  end

  # POST /loans/complete/:id
  def complete
    loan = Loan.out.find(params[:id]).joins(:games).where(owner: logged_in_user) rescue nil

     respond_to do |format|
       if loan.nil?
          format.html { redirect_to root_path }
       else
         loan.status = Loan::STATUS_COMPLETED
         if loan.save
           flash[:success] = "The hold on #{loan.game.title} for #{loan.user.name} has been completed"
              format.html { redirect_to account_user_path(logged_in_user) }
        else
          flas h[:error] = "Could not update loan status for #{loan.game}"
          forma t.html{ redirect_to account_user_path(logged_in_user) }
        end
      end
    end
  end
end
