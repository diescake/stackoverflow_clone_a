import assert from 'power-assert';
import Vuex from 'vuex';
import { shallowMount } from '@vue/test-utils';
import '../TestHelper';
import Comment from '@/components/Comment';
import router from '@/router';


describe('Comment', function () {
  let store;
  const comment = {
    user_id: '5aa2100737000037001811c3',
    id: '0GhVJIvT3TUqastruFr9',
    created_at: '2018-05-06T14:00:23+00:00',
    body: 'bodyX',
  };

  beforeEach(function () {
    store = new Vuex.Store({
      state: {
      },
      actions: {
      },
    });
  });

  it('renders answer body and comment components', function () {
    const wrapper = shallowMount(Comment, {
      store,
      router,
      propsData: {
        comment,
      },
    });
    assert(wrapper.find('.body').text().includes(comment.body));
  });
});
