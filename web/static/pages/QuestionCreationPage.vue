<template>
  <div>
    <!--  -->
    <div class="page-title">
      質問を登録する
    </div>

    <!--  -->
    <form
      class="quetion-form"
      @submit.prevent="submit"
    >
      <div class="form-group">
        <label for="form-title">タイトル</label>
        <input
          id="form-title"
          v-model="title"
          :maxlength="titleMaxLength"
          class="title-edit form-control"
          type="text"
          minlength="1"
          required
        >
      </div>

      <div class="form-group">
        <label for="form-body">本文</label>
        <textarea
          id="form-body"
          v-model="body"
          class="body-edit form-control"
          minlength="1"
          maxlength="50"
          required
        />
      </div>

      <!--  -->
      <div class="form-group">
        <button
          class="btn btn-primary mb-2"
          type="submit"
        >
          投稿
        </button>
      </div>
    </form>
    <hr>

    <!--  -->
    <router-link :to="{ name: 'QuestionListPage'}">
      一覧に戻る
    </router-link>
  </div>
</template>

<script>
export default {
  name: 'QuestionCreationPage',

  data() {
    return {
    };
  },


  methods: {
    submit: function () {
      this.$store.dispatch('createQuestion', { title: this.title, body: this.body })
        .then(() => {
          this.$router.push({ path: '/' });
        });
    },

  },
};
</script>

<style scoped>
</style>
