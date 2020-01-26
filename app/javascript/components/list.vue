<template>
  <div>
    <input v-on:keyup="search($event.target.value)" class="searchbar" type="text" placeholder="Search for a post..." name="search">
    <list-item
      v-for="item in itemz"
      :item="item">
    </list-item>
    <div v-if="itemz.length < 1" style="text-align: center">
      <p>No posts found</p>
    </div>
    <div class="flex-grid" v-if="itemz.length > 0">
      <div class="col">
        <div v-if="!isFirstPage" class="arrows" href="">
          <i @click="goToPrevPage" class="fa fa-2x fa-chevron-left icon"></i>
        </div>
      </div>
      <div class="col">
        <h5 class="page-number">Page {{ pageNum }} of {{ numPagesToShow }}</h5>
      </div>
      <div class="col">
        <div v-if="hasNextPage" class="arrows" href="">
          <i @click="goToNextPage" class="fa fa-2x fa-chevron-right icon"></i>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import axios from 'axios';
  import ListItem from '../components/list-item'

  export default {

    components: { ListItem },

    props: {
      items: { required: true, type: Array },
      page: { required: true, type: Number },
      perPage: { required: true, type: Number },
      numberOfPages: { required: true, type: Number }
    },

    created: function() {
      this.configureAxiosHeaders();
    },

    computed: {
      nextPageNum () {
        return this.pageNum + 1
      },

      prevPageNum () {
        return this.pageNum - 1
      },

      isFirstPage () {
        return this.pageNum === 1;
      },

      isLastPage () {
        return this.itemz.length < this.perPage
      },

      numPagesToShow() {
        return this.numPages;
      }
    },

    data: function () {
      return {
        itemz: this.items,
        pageNum: this.page,
        numPages: this.numberOfPages,
        debounce: null,
        hasNextPage: true
      }
    },

    methods: {
      configureAxiosHeaders () {
        const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
        axios.defaults.headers.common['X-CSRF-Token'] = token
        axios.defaults.headers.common['Accept'] = 'application/json'
      },

      search(search) {
        if (this.debounce) { clearTimeout(this.debounce) }

        this.debounce = setTimeout(() => {
          axios.get(`/?page=1&search=${search}&ajax=true`)
            .then((res) => {
              this.numPages = res.data.number_of_pages
              this.hasNextPage = res.data.has_next_page
              this.itemz = res.data.items
            })
            .catch(console.error);
        }, 400);
      },

      goToNextPage () {
        axios.get(`/?page=${this.nextPageNum}&ajax=true`)
          .then((res) => {
            this.itemz = res.data.items
            this.numPages = res.data.number_of_pages
            this.hasNextPage = res.data.has_next_page
            this.pageNum += 1;
          })
          .catch(console.error)
      },

      goToPrevPage () {
        axios.get(`/?page=${this.prevPageNum}&ajax=true`)
          .then((res) => {
            this.itemz = res.data.items
            this.numPages = res.data.number_of_pages
            this.hasNextPage = res.data.has_next_page
            this.pageNum -= 1;
          })
          .catch(console.error)
      }
    }
  }
</script>
