module ApplicationHelper
    def recurring_or_not(bill)
        if bill.recurring
          "fas fa-toggle-on"
        else
          "fas fa-toggle-off"
        end
    end
end