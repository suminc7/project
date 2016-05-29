using UnityEngine;
using System.Collections;

public class SwordController : MonoBehaviour {


	private FirstPersonControl firstPersonControl;
	private Animator anim;

	public GameObject MovingCube;
	public GameObject Player;
	public GameObject Knight;




	void Start () {


		firstPersonControl = Player.GetComponent<FirstPersonControl> ();
		anim = Knight.GetComponent<Animator>();
	}
	
	// Update is called once per frame
	void Update () {
		//Debug.Log (anim.GetBool ("isAttack"));
	}

	void OnTriggerEnter(Collider other) {
		
		if (other.tag == "Monster" && anim.GetBool ("isAttack")) {
			
			MushroomMonster monster = other.gameObject.GetComponent<MushroomMonster>();
			monster.Hit();
			
			
		}
		
	}


}
