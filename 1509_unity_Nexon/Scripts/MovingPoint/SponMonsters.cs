using UnityEngine;
using System.Collections;

public class SponMonsters : MonoBehaviour {

	public MushroomMonster[] monsters;
	//public MushroomMonster king;

	private MovingCubeController movingCubeController;

	bool isFirst = false;
	int len;

	void Start () {
		len = monsters.Length;
		movingCubeController = GameObject.Find("MovingCube").GetComponent<MovingCubeController>();
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	void OnTriggerEnter(Collider other) {

		if (!isFirst) {
			for (int i = 0; i<monsters.Length; i++) {
				MushroomMonster monster = monsters[i];
				monster.Moving(this);
			}
			isFirst = true;
		}



	}

	public void DieMonster(string monsterName){
		/*
		if (monsterName == MushroomMonster.KingName) {
			movingCubeController.ShowCurrentObject();
			return;
		}
*/
		len--;
		if (len == 0) {

			movingCubeController.ShowCurrentObject();
			/*
			if(king){
				king.Moving(this);
			}else{

			}
			*/
		}




	}

}
