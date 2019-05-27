<template>
  <div>
    <div class="body">
      {{ comment.body }}
    </div>
  </div>
</template>

<script>
export default {
  name: 'Comment',

  props: {
    comment: {
      type: Object,
      required: true,
    },
  },

};
</script>

<style scoped>
</style>
