<template>
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
</template>

<script>
export default {
  name: 'QuetionForm',

  props: {
    body: {
      type: Object,
      required: true,
    },
  },
};
</script>
