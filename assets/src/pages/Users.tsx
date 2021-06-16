import { Grid } from '@chakra-ui/react'
import { useEffect } from 'react'
import { FC } from 'react'
import { useDispatch, useSelector } from 'react-redux'
import { IUserForm, SendableUser } from '../components/SendableUser'
import { consts } from '../consts'
import { AppDispatch, RootState } from '../store'
import { EOtherUsersPayloadActions } from '../store/OtherUsersStore'
import { EUserPayloadActions } from '../store/UserStore'
import { IPrivateUser, IUser } from '../types/user'
import { client } from '../utils/client'

const Users: FC = () => {
  const users = useSelector<RootState, IPrivateUser[]>(state => state.otherUsers.users)
  const currentUser = useSelector<RootState, IUser>(state => state.user.user_data)
  const dispatch = useDispatch<AppDispatch>()
  useEffect(() => {
    async function fetchOtherUsers() {
      const res = await client.get<IPrivateUser[]>('/api/users')
      const data = res.data
      dispatch({ type: EOtherUsersPayloadActions.POPULATE, payload: data })
    }
    if (users.length === 0) fetchOtherUsers()
  }, [])

  const onSubmit = (user: IPrivateUser) => async (data: IUserForm) => {
    const res = await client.post(`/api/users/${currentUser.id}/send/${user.id}`, data)
    const payload = res.data
    dispatch({ type: EUserPayloadActions.UPDATE_POINTS, payload })
  }

  return (
    <Grid gridTemplateColumns={['1fr', '1fr 1fr']} gap={4} maxW={consts.readableWidth} px={4} mx="auto" mt="5rem">
      {users
        .filter(({ id }) => id !== currentUser.id)
        .map(user => (
          <SendableUser key={user.id} user={user} maxPoints={currentUser.pool.points} onSubmit={onSubmit(user)} />
        ))}
    </Grid>
  )
}

export default Users
