import { useEffect } from "react"
import { useSelector } from "react-redux"
import { useHistory } from "react-router-dom"
import { RootState } from "../store"
import { IUser } from "../types/user"

export const Me = () => {
    const userData = useSelector<RootState, IUser>(state => state.user.user_data)
    return (
        <div>
            {JSON.stringify(userData)}
        </div>
    )
}