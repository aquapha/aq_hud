export type DataState = {
	isShowing: boolean;
	name: string;
	health: number;
	armor: number;
	hunger: number;
	thirst: number;
	isTalking: boolean;
	cash: number;
	bank: number;
};

const initialDataState = {
	isShowing: true,
	name: "Loading...",
	health: 100,
	armor: 100,
	hunger: 100,
	thirst: 100,
	isTalking: true,
	cash: 0,
	bank: 0,
};

export const updateData = (
	state = initialDataState,
	action: { type: any; payload: any }
) => {
	switch (action.type) {
		case "update":
			return {
				...state,
				...action.payload,
			};
		default:
			return state;
	}
};
