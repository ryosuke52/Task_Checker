<template>
  <div id="app">
     <el-row>
        <el-button
          icon="el-icon-plus"
          @click="createTaskDialog = true"
          type="success"
          circle>
        </el-button>
        <el-col :span="23">
          <el-tabs v-model="activeName">
            <el-tab-pane label="タスク" name="toDo">
              <task-table 
                @sort="sortedTasksByLimit"
                v-bind:tasks="filter(tasks, false)"
                @update="updateTask"
                @destroy="destroyTask"></task-table>
            </el-tab-pane>
            <el-tab-pane label="終了したタスク" name="finishedTask">
              <task-table 
                @sort="sortedTasksByLimit"
                v-bind:tasks="filter(tasks, true)"
                @update="updateTask"
                @destroy="destroyTask"></task-table>       
            </el-tab-pane>
         </el-tabs> 
      </el-col>
   </el-row>
   <el-dialog
     :visible.sync="createTaskDialog"
     width="30%"
     height="100%"
     center>
     <task-form 
        @close="closeDialog"
        @add="addTask">
     </task-form>
   </el-dialog>
  </div>
</template>

<script>
import TaskTable from '../tasks/task-table'
import TaskForm from '../tasks/task-form'
import axios from 'axios'
import {reject, filter} from 'lodash';
   export default {
     data (){   
       return {
         tasks: [],
         activeName: 'toDo',
         createTaskDialog: false
       }
     },
      components: {
        TaskTable,
        TaskForm
      },
     created() {
        axios.get('/api/v1/tasks')
           .then(res => {
               this.tasks = res.data
           })
      },
      methods: {
         destroyTask(id) {
            axios.delete('/api/v1/tasks/' + id)
               .then(res => {
                 if (res.status == 200) {
                    this.tasks = reject(this.tasks, ['id', id]); 
                 }   
               });
      　},
         updateTask(toDo) {
           axios.patch('/api/v1/tasks/' + toDo.id, {task: toDo})
             .then(res => {
               if(res.status == 200) {
                 console.log(res)
               }
             })
      　},
        filter(tasks, finished) {
          return filter(tasks, ['finished', finished])
      　},
        closeDialog() {
          this.createTaskDialog = false 
      　},
        addTask(toDo) {
          this.tasks.push(toDo)   
      　},
      },
    computed: {
     sortedTasksByLimit(){
        return this.tasks.sort((a, b) => {
          return (a.limit < b.limit) ? -1 : (a.limit > b.limit) ? 1 : 0;
        });
      }
    }
   }  
</script>