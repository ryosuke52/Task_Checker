<template>
  <el-table
    :data="tasks"
    style="width: 100%"
    @cell-dblclick="showInput">
    <el-table-column
      prop="finished">
      <template v-slot="scope">
        <el-checkbox
          v-model="scope.row.finished"
          @change="$emit('update', scope.row)">
        </el-checkbox>
      </template>
    </el-table-column>
    <el-table-column
      prop="title">
      <template v-slot="scope">
        <div>{{ scope.row.title }}</div>
        <el-input
          class="hidden"
          v-model="scope.row.title"
          @blur="$emit('update', scope.row); hideInput($event.target.parentNode)">
        </el-input>
      </template>
    </el-table-column>
    <el-table-column
      prop="limit">
      <template slot-scope="scope">
        <div>{{ scope.row.limit }}</div>
        <el-date-picker
          type="datetime"
          format="yyyy/MM/dd HH:mm"
          value-format="yyyy/MM/dd HH:mm"
          class="hidden"
          v-model="scope.row.limit"
          @blur="$emit('update', scope.row); hideInput($event.$el)">
        </el-date-picker>
      </template>
    </el-table-column>
    <el-table-column
      prop="task_info">
      <template v-slot="scope">
        <div>{{ scope.row.task_info }}</div>
        <el-input
          class="hidden"
          v-model="scope.row.task_info"
          @blur="$emit('update', scope.row); hideInput($event.target.parentNode)">
        </el-input>
      </template>
    </el-table-column>
    <el-table-column
      width="120">
      <template v-slot="scope">
        <el-button
          @click="$emit('destroy', scope.row.id)"
          type="danger"
          icon="el-icon-delete"
          circle>
        </el-button>
      </template>
    </el-table-column>
  </el-table>
</template>

<script>
  export default{
    props: ['tasks'],
    methods: {
       showInput(row, column, cell, event) {
          if (column.property === 'title' || column.property === 'limit' || column.property === 'task_info') {
          let children = cell.firstElementChild.children
          children[0].classList.add('hidden')
          children[1].classList.remove('hidden')
          let input = children[1].firstElementChild
          input.focus()
        }
       },
       hideInput(target) {
          target.classList.add('hidden')
          target.previousElementSibling.classList.remove('hidden')
       }
    },
  }
</script>