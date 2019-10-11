require_dependency "mail_flow/application_controller"

module MailFlow
  class FlowsController < ApplicationController
    before_action :set_flow, only: [:show, :update, :destroy]

    def index
      @flows = Flow.all
    end

    def show
    end

    def create
      @flow = Flow.new(flow_params)

      if @flow.save
        render :show, status: :created, location: @flow
      else
        render json: @flow.errors, status: :unprocessable_entity
      end
    end

    def update
      if @flow.update(flow_params)
        render :show, status: :ok, location: @flow
      else
        render json: @flow.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @flow.destroy
      head :no_content
    end

    private

    def set_flow
      @flow = Flow.find(params[:id])
    end

    def flow_params
      params.require(:flow).permit(:name, :active)
    end
  end
end
