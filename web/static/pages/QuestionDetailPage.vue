<template>
  <div>
    <div v-if="hasValidQuestion">
      <question :question="question" />
    </div>
  </div>
</template>

<script>
import Question from '@/components/Question';
import Answer from '@/components/Answer';

export default {
  name: 'QuestionDetailPage',
  components: {
    Question,
    Answer,
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
