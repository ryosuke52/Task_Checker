<template>
  <el-form :model="toDo">
    <el-form-item label="">
      <el-input
        v-model="toDo.title"
        placeholder="タスク名を入力"
        name="task[title]">
      </el-input>
    </el-form-item>
    <el-form-item label="">
      <el-date-picker
        type="datetime"
        format="yyyy/MM/dd HH:mm"
        placeholder="期限を選択"
        v-model="toDo.limit"
        name="task[limit]">
      </el-date-picker>
    </el-form-item>
    <el-form-item label="">
      <el-input
        v-model="toDo.task_info"
        placeholder="メモ欄"
        name="task[task_info]">
      </el-input> 
    </el-form-item>
    <el-form-item>
      <el-button type="primary" @click="createTask">タスク作成</el-button>
      <el-button @click="$emit('close')">キャンセル</el-button>
    </el-form-item>
  </el-form>
</template>

<script>
import axios from 'axios'
  export default {
    data() {
      return {
        toDo: {
          title: '',
          limit: '',
          task_info: '',
          finished: false
        }
      }
    },
    methods: {
       createTask() {
         axios.post('/api/v1/tasks', {task: {title: this.toDo.title, limit: this.toDo.limit, task_info: this.toDo.task_info, finished: this.toDo.finished}})
            .then(res => {
              switch (res.status) {
                case 201:
                  this.$emit('add', res.data)
                  this.toDo = {title: '', limit: '', task_info: '', finished: 'false'}
                  this.$emit('close')
                  break;
                case 400:
                  console.log(res.data.message)
                break;
              }
            });
       }
    }
  }
</script>