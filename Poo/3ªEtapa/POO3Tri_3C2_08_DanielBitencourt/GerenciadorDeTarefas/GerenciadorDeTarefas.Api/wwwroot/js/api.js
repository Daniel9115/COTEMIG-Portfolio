window.apiHelper = {
    async get(url) {
        try {
            const response = await fetch(url, {
                method: 'GET',
                credentials: 'include',
                headers: {
                    'Accept': 'application/json'
                }
            });
            
            if (response.ok) {
                return await response.json();
            }
            
            console.error('Erro na requisição:', response.status);
            return null;
        } catch (error) {
            console.error('Erro:', error);
            return null;
        }
    },

    async post(url, data) {
        try {
            const response = await fetch(url, {
                method: 'POST',
                credentials: 'include',
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(data)
            });
            
            return response.ok;
        } catch (error) {
            console.error('Erro:', error);
            return false;
        }
    },

    async put(url, data) {
        try {
            const response = await fetch(url, {
                method: 'PUT',
                credentials: 'include',
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(data)
            });
            
            return response.ok;
        } catch (error) {
            console.error('Erro:', error);
            return false;
        }
    },

    async delete(url) {
        try {
            const response = await fetch(url, {
                method: 'DELETE',
                credentials: 'include'
            });
            
            return response.ok;
        } catch (error) {
            console.error('Erro:', error);
            return false;
        }
    }
};