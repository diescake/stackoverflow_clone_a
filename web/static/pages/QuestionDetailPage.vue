<template>
  <div>
    <div v-if="hasValidQuestion">
      <question :question="question" />

      <div
        v-for="(comment, index) in question.comments"
        :key="`comment_id-${index}`"
      >
        <comment :comment="comment" />
      </div>
    </div>
  </div>
</template>

<script>
import Question from '@/components/Question';
import Answer from '@/components/Answer';
import Comment from '@/components/Comment';

export default {
  name: 'QuestionDetailPage',
  components: {
    Question,
    Answer,
    Comment,
  },
  data() {
    return {
    };
  },

  computed: {
    // 同じquetionかどうかの確認
    hasValidQuestion() {
      return !(Object.keys(this.question).length === 0) && this.question.id === this.$route.params.id;
    },
    question() {
      return this.$store.state.question;
    },

    commetns() {
      return this.question.comments;
    },

  },

  // ライフサイクルで先にdom構築をする時に呼ばれる
  mounted() {
    this.retrieveQuestion();
  },

  // functionの格納
  methods: {
    retrieveQuestion() {
      this.$store.dispatch('retrieveQuestion', { id: this.$route.params.id });
    },
  },
};
</script>

<style scoped>
</style>
