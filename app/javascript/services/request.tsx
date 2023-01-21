import axios from 'axios'

//Change to URL of the API
const API_BASE_URL: string = ''

export async function getRequest(path: string, params: object): Promise<object> {
    try 
    {
        const response = await axios.get(`/api/v1/${path}`, { params } );
        return response.data;
    } 
    catch (error: any) 
    {
        throw new Error(`Could not get data!`);
    }
}

export async function postRequest(path: string, params: object): Promise<object> {
    try 
    {
        const response = await axios.post(`/api/v1/${path}`, params );
        return response.data;
    } 
    catch (error: any) 
    {
        if (error.response){
            throw new Error(error.response.data.error);
        } else if (error.request) {
            console.log("die");
            throw new Error(error.request);
        } else {
            throw new Error('An error has occcured.')
        }

    }
}

export default getRequest;