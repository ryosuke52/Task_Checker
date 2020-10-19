class Api::V1::TasksController < ActionController::API
  
  def index
    @tasks = Task.all
  end
  
  def destroy
    task = Task.find_by(id: params[:id])
    if task.destroy
      render status: 200, json: { status: 200 }
    end
  end
  
  def update
    @task = Task.find_by(id: params[:id])
    if @task.update(task_params)
      render status: 200, json: { status: 200 }
    end
  end
  
  def create
    @task = Task.new(task_params)
    if @task.save
      render status: :created
    else
      render status: 400, json: { status: 400, message: 'タスクの作成に失敗しました' }
    end
  end
  
  private
  def task_params
    params.require(:task).permit(:title, :limit, :state, :task_info, :finished)
  end
  
end