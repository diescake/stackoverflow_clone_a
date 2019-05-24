<template>
  <div>
    <div class="page-title">
      {{ question.title }}
    </div>
    <div class="body">
      {{ question.body }}
    </div>
  </div>
</template>

<script>
import Comment from '@/components/Comment';

export default {
  name: 'Question',
  components: {
    Comment,
  },

  props: {
    // 受け取った変数をquetionとする
    question: {
      type: Object,
      required: true,
    },
  },
};
</script>

<style scoped>
</style>
