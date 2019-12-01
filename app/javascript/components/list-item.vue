<template>
  <div class="synopsis-wrapper">
    <h2 @click="goToPage" class="fake-anchor">{{ item.title }}</h2>
    <p class="post-synopsis">{{ item.synopsis }}</p>
    <div class="date-tag-row">
      <div class="date-container">
        <p class="date-synopsis"><strong>{{ item.created_at }}</strong></p>
      </div>
      <div class="tags-container">
        <div v-for="tag in item.tags" class=tag-container>
          {{ tag.name }}
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import axios from 'axios';

  export default {

    props: {
      item: { required: true, type: Object }
    },

    created: function() {
      this.configureAxiosHeaders();
    },

    methods: {
      goToPage() {
        window.location.href = `/posts/${this.item.id}`;
      },

      configureAxiosHeaders () {
        const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
        axios.defaults.headers.common['X-CSRF-Token'] = token
        axios.defaults.headers.common['Accept'] = 'application/json'
      }
    }
  }
</script>
