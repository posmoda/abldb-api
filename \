<template>
    <div>
        <form v-on:submit.prevent="doLogin" class="loginForm">
            <p>
                <label>ユーザー名</label>
                <input type="text" placeholder="ユーザー名" v-model="user.userId">
            </p>
            <p>
                <label>パスワード</label>
                <input type="password" placeholder="パスワード" v-model="user.password">
            </p>
            <p>
                <button type="submit">ログイン</button>
            </p>
        </form>
    </div>
</template>
<script>
import jssha from 'jssha'
export default {
    data() {
        return {
            user: {}
        };
    },
    methods: {
        doLogin() {
            //const params = new URLSearchParams();
            //params.append('userId', this.user.userId);
            //params.append('request', 'salt');
            let request = {
                user: this.user.userId,
                order: 'salt'
            }
            let sha = new jssha("SHA-256", "TEXT");
            let salt = '';
            this.axios.post(this.$store.getters.apiRoot + "/login", request).then(response => {
                salt = response.data.salt;
                sha.update(this.user.password + salt);
                let hash = sha.getHash("HEX");
                console.log("firsthash: " + hash);

                const letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
                const userSalt = Array.from(crypto.getRandomValues(new Uint32Array(50))).map((n)=>letters[n%letters.length]).join('')
                console.log(hash + userSalt);
                sha = new jssha("SHA-256", "TEXT"); 
                sha.update(hash + userSalt)
                hash = sha.getHash("HEX")
                console.log("finalhash: " + hash)

                //params.append('hash', hash);
                //params.delete('request');
                //params.append('request', 'auth');
                //params.append('userSalt', userSalt);

                let authRequest = {
                    user: this.user.userId,
                    order: 'auth',
                    userSalt: userSalt,
                    challengeHash: hash
                }

                this.axios.post(this.$store.getters.apiRoot + "/login", authRequest).then(response => {
                    this.$store.commit("UPDATE_USER", {
                        id: response.data.userId,
                        token: response.data.token,
                    });
                    this.$router.push(this.$route.query.redirect);
                });
            });
        }
    }
};
</script>
<style scoped>
.loginForm {
    text-align: center;
    font-size: 1.5rem;
}

</style>
