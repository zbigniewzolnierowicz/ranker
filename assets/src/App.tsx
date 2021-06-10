import React from "react"
import { useCookies } from "./hooks/useCookies"
import { client } from "./utils/client"

export const App = () => {
    const cookies = useCookies()

    const logOut = () => {
        client
            .delete('/auth', { withCredentials: true })
            .then(res => console.log(res))
            .catch(err => console.log(err))
    }
    return (
        <>
            {cookies.get('logged_in') === 'true' ? (
                <a href="/auth/logout">Log out</a>
            ) : (
                <a href="/auth/github">Github</a>
            )}
        </>
    )
}