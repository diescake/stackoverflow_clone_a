<template>
  <div>
    <div v-if="question.userId === LoginId">
      <div>Hogehoge</div>
    </div>

    <!-- ログインidが一致していた場合 -->
    <div v-else>
      <div class="page-title">
        {{ question.title }}
      </div>

      <div class="body">
        {{ question.body }}
      </div>
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

  data() {
    return {
      LoginId: this.$store.state.id,
    };
  },
};
</script>

<style scoped>
</style>
